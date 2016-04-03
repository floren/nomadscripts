use strict;
use warnings;

my $filename = "nomad-files.txt";
open(my $fh, '<:encoding(UTF-8)', $filename)
	or die "Could not open '$filename' $!";

my $prefix = "nomad-files/";

my $fid = "";
my $fname = "";
my $folder = "";
while (my $row = <$fh>) {
	chomp $row;
	if ($row =~ /^-------/) {
		$fid = "";
		$fname = "";
		$folder = "";
	} elsif ($row =~ /^File ID/) {
		$fid = substr($row, index($row, ": ")+2);
		#print $fid,"\n";
	} elsif ($row =~ /^Filename/) {
		$fname = substr($row, index($row, ": ")+2);
		#print $fname,"\n"
	} elsif ($row =~ /^Folder/) {
		$folder = substr($row, index($row, ": ")+2);
		#print $folder,"\n";
		$folder =~ s/\\/\//g;
		#print $folder,"\n";
		my $dpath = join("",$prefix,$folder);
		system("mkdir", "-p", $dpath);
		my $fullpath = join("",$dpath,$fname);
		print "Created '$dpath', now fetching to '$fullpath'\n";
		#print $dpath,"\n";
		#print $fullpath,"\n";
		system("njb-getfile", $fid, $fullpath);
	}

}
