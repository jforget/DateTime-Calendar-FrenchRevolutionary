# For some reasons, 45-lastday.t fails on some CPAN tester's machines.
# To investigate, here is a variant of the same test.

use DateTime::Calendar::FrenchRevolutionary;

my $n = 1;

sub check_last {
  my ($l_m, $l_d, $y, $m, $H, $M, $S) = @_;
  my $dt = DateTime::Calendar::FrenchRevolutionary->last_day_of_month(
            year => $y, month => $m, hour => $H, minute => $M, second => $S);
  if ($l_m eq $dt->month) {
     print "ok $n\n";
  }
  else {
    print "not ok $n : expected $l_m, got $dt->month()\n";
  }
  $n ++ ;
  if ($l_d eq $dt->day) {
     print "ok $n\n";
  }
  else {
    print "not ok $n : expected $l_d, got $dt->day()\n";
  }
  $n ++ ;
}


@tests = ([ 1, 30, 212,  1, 5, 85, 90],
	  [ 2, 30, 212,  2, 5, 85, 90],
	  [ 3, 30, 211,  3, 0, 17, 90],
	  [10, 30, 211, 10, 9, 17, 99],
	  [12, 30, 211, 12, 9,  7,  9],
	  [13,  5, 211, 13, 8,  1,  1],
	  [13,  6, 212, 13, 8,  1,  1],
	  );

printf "1..%d\n", 2 * scalar @tests;

foreach (@tests) {
  check_last @$_;
}
