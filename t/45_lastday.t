use DateTime::Calendar::FrenchRevolutionary;

my $n = 1;

sub check_last {
  my ($n, $date_r, $y, $m, $H, $M, $S) = @_;
  my $dt = DateTime::Calendar::FrenchRevolutionary->last_day_of_month(
            year => $y, month => $m, hour => $H, minute => $M, second => $S);
  my $resul = $dt->iso8601;
  if ($date_r eq $resul)
    { print "ok $n\n" }
  else
    { print "not ok $n : expected $date_r, got $resul\n" }
}


@tests = (["0212-01-30T5:85:90", 212,  1, 5, 85, 90],
	  ["0212-02-30T5:85:90", 212,  2, 5, 85, 90],
	  ["0211-03-30T0:17:90", 211,  3, 0, 17, 90],
	  ["0211-10-30T9:17:99", 211, 10, 9, 17, 99],
	  ["0211-12-30T9:07:09", 211, 12, 9,  7,  9],
	  ["0211-13-05T8:01:01", 211, 13, 8,  1,  1],
	  ["0212-13-06T8:01:01", 212, 13, 8,  1,  1],
	  );

printf "1..%d\n", scalar @tests;

foreach (@tests) { check_last $n++, @$_ }
