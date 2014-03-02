#!/usr/bin/perl -w
use strict;

#30 Apr 2013 - John B. Silvestri
#find-ports.pl - parse the results of the excellent
#TraceMAC tool: http://sourceforge.net/projects/tracemac/

#Input: the result of one or many TraceMAC searches in 'tm-test.txt'
#Output (to STDOUT):
#CSV data w/host MAC and relevant switch name/IP/port/descr.

#30Apr13 ~Done @1855 [Begun: ~1825] - JBS

open INFILE, "<", "tm-test.txt"
	or die "Can't open file for read: $!\n";

my $mac_addr="";
my $port="";
my @hops=();

READLOOP: while (<INFILE>){
	chomp;
	next READLOOP if m/^$/;

	if ($mac_addr eq ""){
		if (m/TraceMAC: (\w{4}.\w{4}.\w{4})/){
			$mac_addr=$1;
		}
	}else{
		if (m/TraceMAC completed!/){
			my $last_hop=pop @hops;
			#print "Done: $mac_addr found as: $last_hop\n";
			#Do something with previous hops?  (Still in @hops)
			unless ($last_hop =~ m/MAC unreachable on this Switch/){
				my ($hop, $switch_name, $junk_1, $switch_ip, $switch_model, $sw_number,
					$sw_vlan, $junk_2, $sw_descr)=split (" ", $last_hop);
				print "$mac_addr, $switch_name, $switch_ip, $sw_number, $sw_descr\n";
			}else{
				print "$mac_addr, MAC_Address_Not_Found\n";
			}
			$mac_addr = "";
			@hops=();
		}else {
			push @hops, $_;
		}

	}

}

close INFILE;
