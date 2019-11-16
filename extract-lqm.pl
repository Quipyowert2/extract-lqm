#!/usr/bin/perl
#Extract text from .LQM (QuickMemo+) files
use strict;
use warnings;
use Archive::Zip;
use Archive::Zip::MemberRead;
use JSON;
use Data::Dumper;
if (!@ARGV) {
    print STDERR<<USAGE;
extract-lqm.pl <.LQM file>
Extract text from .LQM (QuickMemo+) files
Outputs the resulting text on stdout.
Put '>output.txt' after the LQM file to send output to a file named output.txt
USAGE
    exit 1;
}
my $lqm = shift @ARGV;
my $zip = Archive::Zip->new($lqm);
my $fh = Archive::Zip::MemberRead->new($zip, "memoinfo.jlqm");
my $json = "";
while (defined(my $line = $fh->getline())) {
    $json .= $line;
}
my $dJson = decode_json($json);
print $dJson->{MemoObjectList}->[0]->{"DescRaw"};
