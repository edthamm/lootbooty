#!/usr/bin/ruby

##################################################################################################
# Created by: PuNk1nPo0p "Morals over Law"					     		 #
##################################################################################################

require 'colorize'
require './modules/peapingtom'
require './modules/ipwner'

#GLOBAL_VARIABLES--------------------------------------------------------------------------------#

@prompt = ": ".light_white	

#MAIN_MENU---------------------------------------------------------------------------------------#

def main_menu
	system("clear")
	print "  _            ___  _   ____         ___  _     
 | |          / _ \\| | |  _ \\       / _ \\| |".light_white,"   		____________________".yellow,"
 | |     ___ | | | | |_| |_) | ___ | | | | |_ _   _ ".light_white,"   /\\_________".yellow,"{".light_white,"-".yellow,"}".light_white,"_______\\".yellow,"
 | |    / _ \\| | | | __|  _ < / _ \\| | | | __| | | |".light_white,"  / /	          / /".yellow,"
 | |___| (_) | |_| | |_| |_) | (_) | |_| | |_| |_| |".light_white," | /".yellow,"    ,".light_white,"*".light_green,".".light_white,"          / /".yellow,"
 |______\\___/ \\___/ \\__|____/ \\___/ \\___/ \\__|\\__, |".light_white," `.".yellow," ,".light_white,",".light_cyan,"~".blue,"0".light_red,"$".light_yellow,"&".magenta,"*".light_magenta,"..".light_white,",".blue,"0".green,"@~".light_blue,"?".red,"  . /".yellow,"
 				 ________________/ |".light_white," |\\".yellow,"@".light_cyan,"#".light_red,"#".light_blue,"$^".light_yellow,"*".light_white,"%".red,"$".light_green,"3".blue,"^@".light_magenta,"@".light_yellow,"!".light_cyan,"-".cyan,"$".green,"@".light_red,"&".light_cyan,"*".light_white," \\".yellow,"
 ######### MAIN MENU ##########".light_green,"	|___".light_white,"Wifi".light_green,"_".light_white,"Tools".light_green,"____/".light_white,"  | \\".yellow,"0".light_white,"*".blue,"$".red,"(0)".light_cyan,"$".light_green,"%%".blue,";".red,"'%".light_magenta,"^".light_yellow,"&".green,"@".yellow,"!".light_red,"*".light_white,"%".cyan,"~".light_white,"\\".yellow,"
						     |  {---------".yellow,"{-}".light_white,"-------}\n".yellow
	print " 1.".light_white," PEAPING TOM".light_cyan,"					      \\ {".yellow,"         {-}".light_white,"       }\n".yellow
	print " 2.".light_white," I-PWNER (".light_cyan,"IOS/OSX Only!".light_white,")".light_cyan," 		 	       \\{___________________}\n".yellow
	print " 3.".light_white," ABOUT\n".light_cyan    
	print " 4.".light_white," EXIT\n".light_cyan
	puts ""	                              
		@option = 0
		until @option != 0  and @option < 5 do print "WHAT DO YOU WANT TO DO?".light_yellow,@prompt
		@option = gets.to_i
		end
		if @option == 1 then peapingtom_menu
		end
		if @option == 2 then ipwner_menu
		end
		if @option == 3 then about_info
		end
		if @option == 4 then system("killall lo0tbo0ty.rb")
		end
end

def about_info
	system("clear")
	print "######################################################\n".light_white,
"##########".light_white," HAVOC-APPS: Lo0tBo0ty Wifi-To0lz".light_green," ##########\n".light_white,
"##########".light_white," Version: 1.0".light_green,"		   	    ##########\n".light_white,
"##########".light_white," Created by: PuNk1nPo0p".light_green,"           ##########\n".light_white,
"##########".light_white," Support: www.lootbooty.com".light_green,"       ##########\n".light_white,
"######################################################\n".light_white
	puts""
	print"Continue?".light_yellow,@prompt
	@option = gets.chomp
	main_menu
end


#END---------------------------------------------------------------------------------------------#

main_menu
