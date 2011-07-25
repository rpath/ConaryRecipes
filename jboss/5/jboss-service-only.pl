#!/usr/bin/env perl

open(STDERR, ">>/var/log/jboss-config.log");
open(STDOUT, ">&STDERR");

sub stamp {
    ($msg) = @_;
    return localtime() . ": $$: " . $msg;
}

sub log {
    ($msg) = @_;
    print STDERR stamp($msg) . "\n";
}


$enabled = $ENV{'config_jboss_enabled'};

&log("START $0 enabled=$enabled");

$enabled = $enabled =~ /^\s*[t1y]/ ? 1 : 0;

# Start/stop jboss.
$cmd = "/sbin/service jboss " . ($enabled ? "restart" : "stop");
system($cmd) && die stamp("failed to run $cmd");

&log("done");
