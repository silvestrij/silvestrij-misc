#!/usr/bin/perl -w
use strict;

#12 Mar 2006 - John B. Silvestri
#quar-restore.pl - prepares a .bat file to
#restore files placed into quarantine by McAfee
#(Created in light of a false positive that moved
#many legitimate files.)

open INFILE, "<", "infected.log"
	or die "Could not open file for read: $!\n";

open OUTFILE, ">", "restore-files.bat"
	or die "Could not open file for write: $!\n";

while (<INFILE>){
	chomp;
	my ($orig_file, $quar_file)=split(" => ");
	print OUTFILE qq|copy "$quar_file" "$orig_file"\n|;
}
