:global telegramToken "bot_token";
:global telegramUser "user_id";
:global wirelessMessage "";
:local conns [/interface wireless registration-table print count-only];

:if ($conns = 0) do={ 
:set wirelessMessage "<b>%F0%9F%93%B1Wireless Connections%F0%9F%93%B6</b>%0A%0AConnected <i>$conns</i> Devices%0A%0A%F0%9F%87%BA%F0%9F%87%B8Enclave RouterOS%F0%9F%92%BB %23wlan";
} else={ 
:local counts ($conns - 1); 
:set wirelessMessage "<b>%F0%9F%93%B1Wireless Connections%F0%9F%93%B6</b>%0A%0AConnected <i>$conns</i> Devices%0A%0A<b>IF</b>          <b>MAC</b>                               <b>Uptime</b>%0A";
/interface wireless registration-table print
:for i from=0 to=$counts do={
	:local deviceIf [/interface wireless registration-table get number=$i interface];
	:local deviceMac [/interface wireless registration-table get number=$i mac];
	:local deviceUptime [/interface wireless registration-table get number=$i uptime];
	:set $wirelessMessage "$wirelessMessage<i>$deviceIf</i> - <code>$deviceMac</code> - <i>$deviceUptime</i>%0A";
};
:set $wirelessMessage "$wirelessMessage%0A%F0%9F%87%BA%F0%9F%87%B8Enclave RouterOS%F0%9F%92%BB %23wlan";
}

:local tgUrl "https://api.telegram.org/bot$telegramToken/sendMessage?chat_id=$telegramUser&text=$wirelessMessage&parse_mode=html&disable_notification=true";

/tool fetch url="$tgUrl" mode=http keep-result=no;  