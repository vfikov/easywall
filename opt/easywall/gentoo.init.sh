#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/radvd/files/radvd.init,v 1.5 2011/11/14 02:23:28 xmw Exp $

depend() {
	need net
	provide easywall
}

start() {
	ebegin "Starting EasyWall Firewall"
	start-stop-daemon --start --exec /usr/bin/firewall start
	eend $?
}

stop() {
	ebegin "Stopping EasyWall Firewall"
	start-stop-daemon --stop --exec /usr/bin/firewall stop
	eend $?
}

reload() {
	ebegin "Reloading EasyWall Firewall"
	start-stop-daemon --start --exec /usr/bin/firewall restart
	eend $?

}
