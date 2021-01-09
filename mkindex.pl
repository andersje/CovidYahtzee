#!/usr/bin/perl

##open my $fh "./index.html" or die "index not writable? $1";

sub mkheader() {
  print "<html>\n<head><title>Yahtzee Scores</title></head><body bgcolor=white>\n";
  return;
}

sub mkfooter($$$) {
  print "<p>We have played $_[0] games so far, beginning on $_[1].  Our last game was played on $_[2].</p>\n";
  print "</body></html>\n";
  return
}

sub mk_alt_txt($) {
  my $raw_filename=$_[0];

  my ($blah, $date, $time) = split /\s+/,$raw_filename;

####  print("date of $raw_filename is $date\n");


  return "$date";
}

my $gamecount=0;
my $gamedate="";
my $firstdate="";
mkheader();
open my $cmd, 'ls images|';
while ($thing=<$cmd>) {
  chomp $thing;
  $gamecount++;
  $result=mk_alt_txt($thing);
  if ($gamecount == 1) { $firstdate=$result; } else { $gamedate=$result; }
  print("<a href='images/$thing'><img src='images/$thing' width=160 alt_text='$result'> Yahtzee from $result </a><br />\n")
  }
close $cmd;
 
mkfooter($gamecount,$firstdate,$gamedate);
