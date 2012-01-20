#!/usr/bin/perl
$start_run = time();
$get=`cat /var/log/sshd.log | grep "failure for" | grep -v "illegal" | cut -d":" -f6 | cut -b2- |  awk '{print \$6}' | sort -n | uniq | grep -v "[a-z]"`;
@lines = split /\n/, $get;
open (HOSTFILE, '>>/var/log/failed-ip-host-info.log');
open (MYFILE, '>>/var/log/failed-ip-list.log');
$clearold=`cat /dev/null > /root/iptables.sh`;
open (IPTSCR, '>>/root/iptables.sh');
print "Starting cycle:";
foreach $line (@lines) {
	print MYFILE "$line\n";
	$hh=`host $line`;
	chomp($hh);
	print HOSTFILE "$line [ $hh ]\n";
	print IPTSCR "/sbin/iptables -I INPUT -s $line -p tcp --dport 22 -j REJECT --reject-with tcp-reset\n";
	print ".";
}
print IPTSCR "/etc/init.d/iptables save\n";
close(IPTSCR);
close(HOSTFILE);
close(MYFILE);
$end_run = time();
$run_time = $end_run - $start_run;
print "\nCycle finished!\nJob took $run_time seconds to complete!\n";
$clearssh=`cat /dev/null > /var/log/sshd.log`;
