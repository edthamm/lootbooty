#!/usr/bin/ruby
##################################################################################################
# Created by: PuNk1nPo0p 									 #
##################################################################################################
require 'colorize'
#MAIN_MENU---------------------------------------------------------------------------------------#

def sysprep_menu
	system("clear")
	print "####### SYSTEM PREP #######\n".light_green 	
	puts ""               
	print "1.".light_white," INSTALL\n".light_cyan	
	print "2.".light_white," UNINSTALL\n".light_cyan
	print "3.".light_white," EXIT\n".light_cyan
	puts ""
		@option = 0
		until @option != 0 and @option < 4 do print @start,"PICK ONE?".light_yellow,@prompt
		@option = gets.to_i
		end
		if @option == 1 then install_all
		end
		if @option == 2 then uninstall_all
		end
		if @option == 3 then system("killall sysprep.rb")
		end
end

#INSTALLERS--------------------------------------------------------------------------------------#

def install_all
	uninstall_radius
	uninstall_hostapd
	install_packages
	install_radius
	config_netmanager
	print "(o)".light_blue,"Install Complete, Hit enter to continue".light_green,@prompt
	@continue = gets.chomp
	sysprep_menu
end

def install_packages
	system("xterm -e apt-get install libssl-dev libnl-dev bridge-utils hostapd patch dnsmasq")
end

def config_netmanager
	system("killall dnsmasq && /etc/init.d/dnsmasq start && /etc/init.d/network-manager restart")
end

def install_radius
	Dir.chdir("installers")
	system("xterm -e tar -xvf freeradius-server-2.1.12.tar.gz")
	Dir.chdir("freeradius-server-2.1.12")
	system("cp ../../patches/PuNk1n.patch .")
	system("patch -p1 < PuNk1n.patch")
	system("xterm -e ./configure && xterm -e make && xterm -e make install && xterm -e ldconfig")
	Dir.chdir("../../")
end	

#UNINSTALLERS------------------------------------------------------------------------------------#

def uninstall_all
	uninstall_radius
	uninstall_hostapd
	print "(o)".light_blue,"Uninstall Complete, Hit enter to continue".light_green,@prompt
	@continue = gets.chomp
	sysprep_menu
end

def uninstall_radius
	if Dir.exists?("/usr/local/etc/raddb") or Dir.exists?("installers/freeradius-server-2.1.12/") then
	system("rm -rf installers/freeradius-server-2.1.12")
	system("rm -rf /usr/local/etc/raddb")
	system("rm -rf /usr/local/sbin/rc.radiusd")
	system("rm -rf /usr/local/sbin/radiusd")
	system("rm -rf /usr/local/var/run/radiusd")
	system("rm -rf /usr/local/include/freeradius/radiusd.h")
	system("rm -rf /usr/local/lib/libfreeradius*")
	system("rm -rf /usr/local/share/freeradius")
	system("rm -rf /usr/local/share/doc/freeradius")
	system("rm -rf /usr/local/include/freeradius")
	system("rm -rf /usr/local/var/log/radius")
	system("rm -rf /usr/lib/pppd/2.4.5/radius.so")
	system("rm -rf /usr/local/share/man/man5/radiusd.conf.5")
	system("rm -rf /usr/local/share/man/man8/radiusd.8")
	system("rm -rf /usr/share/man/man8/pppd-radius.8.gz")
	end
end

def uninstall_hostapd
	if Dir.exists?("/opt/hostapd-1.0/") or Dir.exists?("/etc/hostapd/") then
	system("xterm -e apt-get remove --purge hostapd")
	system("rm -rf /opt/hostapd-1.0/")
	end
end

#END---------------------------------------------------------------------------------------------#
sysprep_menu


