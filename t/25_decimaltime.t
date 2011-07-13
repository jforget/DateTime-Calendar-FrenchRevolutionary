use DateTime::Calendar::FrenchRevolutionary;

# Yes, that's shotgun testing. You have in the end 990 tests and the
# 0.08 version would fail 57/990. So I guess that it is still a good
# set of data for the test
my @hours = (0..9);
my @minutes = qw/0 3 8 12 23 42 65 77 99/;
my @seconds = qw/0 2 5 10 18 26 37 56 64 88 99/;
my $nb_tests = @hours * @minutes * @seconds;

my $n = 1;

sub check_time {
  my ($n, $h, $m, $s) = @_;
  my $dt = DateTime::Calendar::FrenchRevolutionary->new(
            year => 1, month => 2, day => 3, hour => $h, minute => $m, second => $s);
  my $resul    = $dt->iso8601;
  my $expected = sprintf "0001-02-03T%d:%02d:%02d", $h, $m, $s;
  if ($expected eq $resul) {
    print "ok $n\n";
  }
  else {
    print "not ok $n : expected $expected, got $resul\n";
  }
}


printf "1..$nb_tests\n";

for my $h (@hours) {
  for my $m (@minutes) {
    for my $s (@seconds) {
      check_time $n++, $h, $m, $s;
    }
  }
}
