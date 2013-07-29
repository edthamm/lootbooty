#!/usr/bin/ruby
##################################################################################################
# Created by: PuNk1nPo0p					     				 #
# USER OPTIONS							       				 #
##################################################################################################

#FUNCTIONS---------------------------------------------------------------------------------------#

def get_interface 
	@interface = ""
	until @interface != "" and $? == 0 do print @start,"WIRELESS INTERFACE?".light_yellow,@prompt
	@interface = gets.chomp
	`ifconfig #@interface`
	end
end

def get_essid
	@essid = ""
	until @essid != "" do print @start,"SSID?".light_yellow,@prompt
	@essid = gets.chomp
	end
end

def get_bssid 
	@bssid = ""
	print @start,"SPOOFED MAC?".light_yellow,@prompt
	@bssid = gets.chomp
end

def get_channel
	print @start,"CHANNEL?".light_yellow,@prompt
	@channel = gets.to_i
	if @channel == "" or @channel == 0 then @channel = 9
	end	
	until @channel <= 14 do print @start,"Channel (1-14)".light_yellow,@prompt
	@channel = gets.to_i
	end
end

def get_eap_type
	@eaptype = 0
	print "######### ".light_green," EAP-TYPE".light_white,"  #########".light_green,"\n"
	puts ""
	print " 1. ".light_white,"PEAP-MSCHAPv2\n".light_cyan
	print " 2. ".light_white,"PEAP-GTC\n".light_cyan
	print " 3. ".light_white,"LEAP\n".light_cyan
	print " 4. ".light_white,"MD5\n".light_cyan
	puts ""
	until @eaptype != 0 and @eaptype < 5 do print @start,"PICK ONE?".light_yellow,@prompt
	@eaptype = gets.to_i
	end
	if @eaptype == 1 then @eaptype = "peap" and @peapv = "mschapv2"
	end
	if @eaptype == 2 then @eaptype = "peap" and @peapv = "gtc"
	end
	if @eaptype == 3 then @eaptype = "leap"
	end
	if @eaptype == 4 then @eaptype = "md5"
	end
	
end

def get_crypt
	@crypt = 0
	until @crypt != 0 and @crypt < 3 do print @start,"WPA 1 or 2?".light_yellow,@prompt
	@crypt = gets.to_i
	end
end
