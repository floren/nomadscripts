use strict;
use warnings;

my $filename = "nomad-tracks.txt";
open(my $fh, '<:encoding(UTF-8)', $filename)
	or die "Could not open '$filename' $!";

my $prefix = "nomad-songs/";
system("mkdir", $prefix);

my $title = "";
my $artist = "";
my $fid = "";
while (my $row = <$fh>) {
	chomp $row;
	if ($row =~ /^-------/) {
		$title = "";
		$artist = "";
		$fid = "";
	} elsif ($row =~ /^TITLE:/) {
		$title = substr($row, index($row, ": ")+2);
	} elsif ($row =~ /^ID:/) {
		$fid = substr($row, index($row, ": ")+2);
		#print $fid,"\n";
	} elsif ($row =~ /^ARTIST/) {
		$artist = substr($row, index($row, ": ")+2);
		#print $folder,"\n";
		my $path = sprintf("%s-%s.mp3", $artist, $title);
		my $fullpath = join("",$prefix,$path);
		print "fetching to '$fullpath'\n";
		#print $dpath,"\n";
		#print $fullpath,"\n";
		system("njb-gettr", $fid, $fullpath);
	}

}
