#!/usr/bin/perl
#Extract text from .LQM (QuickMemo+) files
use strict;
use warnings;
use Archive::Zip;
use Archive::Zip::MemberRead;
use JSON;
use Data::Dumper;
my $lqm = shift @ARGV;
my $zip = Archive::Zip->new($lqm);
my $fh = Archive::Zip::MemberRead->new($zip, "memoinfo.jlqm");
my $json = "";
while (defined(my $line = $fh->getline())) {
    $json .= $line;
}
my $dJson = decode_json($json);
print $dJson->{MemoObjectList}->[0]->{"DescRaw"};
