:global telegramToken "bot_token";
:global telegramUser "user_id";
:local routerName [/system identity get name];
:local voltage [/system health get voltage];
:local temp [/system health get temperature];
:local platform [/system resource get platform];
:local boardName [/system resource get board-name];
:local uptime [/system resource get uptime];
:local freeMemory [/system resource get free-memory];
:local totalMemory [/system resource get total-memory];
:local memoryUsage (100 - ((100 * $freeMemory) / $totalMemory));
:local cpuLoad [/system resource get cpu-load];
:local cpuFrequency [/system resource get cpu-frequency];
:local freeHddPlace [/system resource get free-hdd-space];
:local totalHddPlace [/system resource get total-hdd-space];
:local hddUsage (100 - ((100 * $freeHddPlace) / $totalHddPlace));
:local osVersion [/system resource get version];
:local buildTime [:pick [/system resource get build-time] 0 11];
:local systemTime [/system clock get time];
:local systemDate [/system clock get date];
:local publicIP [/ip cloud get public-address];

:local statusMessage "<b>%F0%9F%93%88Router Status%F0%9F%93%89</b>%0A%0ARouter Name: <i>$routerName</i>%0APlatform: <i>$platform</i>%0ABoard Name: <i>$boardName</i>%0ACPU: <i>$cpuLoad% - $cpuFrequency MHz</i>%0ARAM: <i>$freeMemory / $totalMemory B - $memoryUsage%</i>%0AROM: <i>$freeHddPlace / $totalHddPlace B - $hddUsage%</i>%0ARouterOS: <i>$osVersion $buildTime</i>%0AUptime: <i>$uptime</i>%0ASystem Time: <i>$systemTime</i>%0ASystem Date: <i>$systemDate</i>%0AIP: <code>$publicIP</code>%0A%0A%F0%9F%87%BA%F0%9F%87%B8Enclave RouterOS%F0%9F%92%BB %23status";

:local tgUrl "https://api.telegram.org/bot$telegramToken/sendMessage?chat_id=$telegramUser&text=$statusMessage&parse_mode=html&disable_notification=true";

/tool fetch url="$tgUrl" mode=http keep-result=no;