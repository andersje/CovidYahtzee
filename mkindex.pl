#!/usr/bin/perl

##open my $fh "./index.html" or die "index not writable? $1";

sub mkheader() {
  print "<html>\n<head><title>Yahtzee Scores</title><style>table, th, td { border: 1px solid black; text-align: center;}</style></head><body bgcolor=white>\n";
  return;
}

sub mk_alt_txt($) {
  my $raw_filename=$_[0];

  my ($blah, $date, $time) = split /\s+/,$raw_filename;

####  print("date of $raw_filename is $date\n");


  return "$date";
}

sub add_pictures_to_page() {

  ### PUT IN PICTURES

  open my $cmd, 'ls images|';
  while ($thing=<$cmd>) {
    chomp $thing;
    $gamecount++;
    $result=mk_alt_txt($thing);
    if ($gamecount == 1) { $firstdate=$result; } else { $gamedate=$result; }
    print("<a href='images/$thing'><img src='images/$thing' width=160 alt_text='$result'> Yahtzee from $result </a><br />\n")
    }
  close $cmd;
  print("\n</p>\n");
  
 
  return;
} 

sub mkfooter($$$) {
  print "<p>We have played $_[0] games so far, beginning on $_[1].  Our last game was played on $_[2].</p>\n";
  print "</body></html>\n";
  return
}


sub add_scorehash() {  
  
  my %scorehash="";

  opendir my $dh,"./scores";
  my @scorefiles = readdir $dh;
  foreach my $scorefile (@scorefiles) {
    ## open the file, add the stats.
    open(SF, '<', "./scores/$scorefile") or die $!;
    my $round_high=0;
    my $round_winner="";
    while (my $line=<SF>) {
      chomp $line;
      my ($player, $score) = split /\s+/,$line;
      $scorehash{"$player"}{'low'} += 0;
      $scorehash{"$player"}{'rounds_played'} += 0;
      $scorehash{"$player"}{'total_wins'} += 0;
      if ($player =~ "[a-zA-Z0-9]") {
  
        if ($scorehash{"$player"}{'high'} lt $score) { 
          $scorehash{"$player"}{'high'} = $score; 
        }
        if ($scorehash{"$player"}{'low'} eq 0) { 
          $scorehash{"$player"}{'low'}=$score; 
        }
        if ($scorehash{"$player"}{'low'} gt $score) { 
          $scorehash{"$player"}{'low'}=$score; 
        }
        my $lowscore=$scorehash{"$player"}{'low'};
        $scorehash{"$player"}{'rounds_played'}++;
  
        if ($score > $round_high) {  $round_high=$score; $round_winner=$player; } 
      }
    }
    close(SF);
    #now we can print results, and record a round_win for this person
    if ($round_winner =~ /[a-zA-Z0-9]/) {
      $scorehash{"$round_winner"}{'total_wins'}++;
    }
  }
  closedir $dh;

  print("<p><table><thead><tr><th>Player</th><th>Games Played</th><th>Games Won</th><th>All-time high</th><th>All-time Low</th></tr></thead>\n");
  print("<tbody>\n");

  for(sort(keys %scorehash)) {
    if ($_ =~ "[a-zA-Z0-9]") {
    print("<tr><td style=\"background-color:powderblue;\">$_</td>\n");
    printf("<td>%s</td>\n", $scorehash{"$_"}{'rounds_played'});
    printf("<td>%s</td>\n", $scorehash{"$_"}{'total_wins'});
    printf("<td>%s</td>\n", $scorehash{"$_"}{'high'});
    printf("<td>%s</td>\n", $scorehash{"$_"}{'low'});
    print("</tr>\n");

    }
  } 
  print("</tbody></table>\n");
  return;
}

$gamecount=0;
$gamedate="";
$firstdate="";

mkheader();
add_scorehash();
add_pictures_to_page();
mkfooter($gamecount,$firstdate,$gamedate);
