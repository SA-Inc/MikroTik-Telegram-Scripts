:global telegramToken "bot_token";
:global telegramUser "user_id";
:local bootTimeFile "boot_time.txt";
:local systemTime [/system clock get time];
:local systemDate [/system clock get date];

/file print file=$bootTimeFile;
/file set $bootTimeFile contents="$systemDate $systemTime";

:local statusMessage "%F0%9F%9A%80<b>Startup Status</b>%F0%9F%93%85%0A%0AThe Router was rebooted%0Aat: <i>$systemTime</i>%0Aon: <i>$systemDate</i>%0A%0A%F0%9F%87%BA%F0%9F%87%B8Enclave RouterOS%F0%9F%92%BB %23startup";
:local tgUrl "https://api.telegram.org/bot$telegramToken/sendMessage?chat_id=$telegramUser&text=$statusMessage&parse_mode=html&disable_notification=true";
:delay 300;
/tool fetch url="$tgUrl" mode=http keep-result=no;
