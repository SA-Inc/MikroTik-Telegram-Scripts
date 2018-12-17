:global telegramToken "bot_token";
:global telegramUser "user_id";
:local bootTimeFile "boot_time.txt";
:local bootTime [/file get $bootTimeFile contents]
:local ssh;
:local routerWanDownload;
:local routerWanUpload;

/ip firewall filter {
	:foreach i in=[find] do={
		:if ($i = "*D") do={
			:set ssh ("%F0%9F%94%92<b>SSH</b> - "."Bytes: "."<i>".[get $i bytes]."</i>"." Packets: "."<i>".[get $i packets]."</i>");
		}
		:if ($i = "*1") do={
			:set routerWanDownload ("%F0%9F%93%A5<b>WAN Download</b> - "."Bytes: "."<i>".[get $i bytes]."</i>"." Packets: "."<i>".[get $i packets]."</i>");
		}
		:if ($i = "*11") do={
			:set routerWanUpload ("%F0%9F%93%A4<b>WAN Upload</b> - "."Bytes: "."<i>".[get $i bytes]."</i>"." Packets: "."<i>".[get $i packets]."</i>");
		}
	}
}

:local statusMessage "%F0%9F%8C%90<b>WAN Status</b>%F0%9F%94%81%0A%0A$routerWanDownload%0A$routerWanUpload%0A$ssh%0A%0ASince: <i>$bootTime</i>%0A%0A%F0%9F%87%BA%F0%9F%87%B8Enclave RouterOS%F0%9F%92%BB %23wan";

:local tgUrl "https://api.telegram.org/bot$telegramToken/sendMessage?chat_id=$telegramUser&text=$statusMessage&parse_mode=html&disable_notification=true";

/tool fetch url="$tgUrl" mode=http keep-result=no;