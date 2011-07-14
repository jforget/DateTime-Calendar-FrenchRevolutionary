use DateTime::Calendar::FrenchRevolutionary;

my $n = 1;
my @tests = ( [ "0:41:66", "0:41:67",  1,  0,  0],
              [ "0:72:91", "0:72:92",  1, 45,  0],
              [ "0:85:46", "0:85:47",  2,  3,  4],
              [ "7:99:99", "8:00:00", 19, 12,  0],
              [ "8:99:99", "9:00:00", 21, 36,  0],
            );

sub check_time {
  my ($n, $ch1, $ch2, $h, $m, $s) = @_;
  my $dt = DateTime::Calendar::FrenchRevolutionary->new(
            year => 1, month => 2, day => 3, abt_hour => $h, abt_minute => $m, abt_second => $s);
  my $resul    = $dt->iso8601;
  my $expected1 = "0001-02-03T" . $ch1;
  my $expected2 = "0001-02-03T" . $ch2;
  if ($resul eq $expected1 or $resul eq $expected2) {
    print "ok $n\n";
  }
  else {
    print "not ok $n : expected $expected1 or $expected2, got $resul\n";
  }
}


printf "1..%d\n", scalar @tests;

for (@tests) {
  check_time $n++, @$_;
}
