#!/usr/bin/perl -w
use strict;

my $foo=shift @ARGV;

#print "First arg: $foo;\n";
open INFILE, '<', $foo
	or die "Can't open file for read: $!\n";

my $outfile=$foo;
$outfile=~s/txt$/addrs.txt/;

open OUTFILE, '>', $outfile
	or die "Can't open file for write: $!\n";


while (<INFILE>){
	chomp;
	print OUTFILE "$_\tFOO\n";
}
close INFILE;
close OUTFILE;

#chomp(my $bar=<STDIN>);
