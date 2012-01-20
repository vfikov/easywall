#!/usr/bin/perl
$config = "/etc/easywall.conf";
open(CONFIG, $config) or die $_;
while (<CONFIG>) {
    chomp;
    next if /^\s*\#/;
    next unless /=/;
    my ($key, $variable) = split(/=/,$_,2);
    $variable =~ s/(\$(\w+))/$config{$2}/g;
    $config{$key} = $variable;
}

if($config{lang} eq "bg"){
    require '/usr/lib/easywall/LangBG.pl';
    $lng = text();
}elsif($config{lang} eq "en"){
    require '/usr/lib/easywall/LangEN.pl';
    $lng = text();
}