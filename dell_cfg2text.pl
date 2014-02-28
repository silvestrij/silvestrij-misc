#!/usr/bin/perl -w
use strict;

#cfg2txt.pl
#28 September 2004 by John B. Silvestri
#
#Parses a directory of Dell Switch Configuration files (.cfg),
#writing them out as tab delimited text files (.txt) to map
#port number to port description
#
#Usage:
#From inside a directory containing .cfg file(s), run cfg2txt.pl
#i.e.
#I:\switch-config>cfg2txt.pl

my @files=<*.cfg>;
my $currfile;

open MASTERLIST, ">", "masterlist.txt"
        or die "Could not open file: $!\n";

foreach $currfile (@files){
        open (INFILE, "<", "$currfile")
                or die "Could not open file: $!\n";
        my @portlist;
        my ($switchip, $switchdescr, $switchloc)=("","","");
        FILELOOP: while (<INFILE>){
                chomp;
                next FILELOOP if(m#exit#);
                if (m#interface ethernet (\d/e\d{1,2})#){
                        my $port=$1;
                        chomp($_=<INFILE>);
                        if(m/description "?([\w\d\- ]*)"?/){
                                my $descr=$1;
                                push (@portlist, "$port\t$descr");
                        }
                #Ex.  interface range ethernet        2/e (      1-      6 )
                }elsif (m#interface range ethernet ((\d/e\(\d{1,2}-\d{1,2}\),?){1,})#){
                #                              $2    ----EE---------------EE--     
                #                              $1   ------------------------------- 
                        my $out=$1;
                        my @parts=split(',',$out);
                        my $i; #indiv_sec
                        my @multiports;
                        foreach $i (@parts){
                                #Ex.        2/e  (      1-      6 )
                                $i =~   m#(\d/e)\((\d{1,2})-(\d{1,2})\)#;
                                #          ---- EE -------   ------- EE     
                                my ($prefix, $start, $stop)=($1,$2,$3);
                                my $cpn; #curr_port_num
                                foreach $cpn ($start..$stop){
                                        push (@multiports, "${prefix}${cpn}");
                                }
                        }#end foreach (@parts)
                        chomp($_=<INFILE>);
                        if(m/description "?([\w\d\- ]*)"?/){
                                my $descr=$1;
                                my $cpn;
                                foreach $cpn (@multiports){
                                        push (@portlist, "$cpn\t$descr");
                                }
                        }


                }elsif(m#ip address (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})#){
                        $switchip=$1;
                #}elsif(m#hostname "(.*)"#){
                }elsif(m/hostname "?([\w\d\- ]*)"?/){
                        $switchdescr=$1;
                #}elsif(m#snmp-server location "(.*)"#){
                }elsif(m/snmp-server location "?([\w\d\- ]*)"?/){
                        $switchloc=$1;
                }else{
                        next FILELOOP;
                }
        }#end FILELOOP

        close INFILE;

        my $outfn=$currfile;
        $outfn=~s/\.cfg/\.txt/;

        open (OUTFILE, ">", "$outfn");
        print OUTFILE "$switchdescr\n$switchip\n$switchloc\n";
        foreach (@portlist){
                print OUTFILE "$_\n";
                print MASTERLIST "$switchdescr\t$_\n";
        }
        close OUTFILE;
}#end foreach (@files)

close MASTERLIST;