#
# Checking negative dates. What matters is only that you can convert *to*
# a negative revolutionary date and then *from* the same date and get
# the same result.
# That is, we do not check the dates are correct, we check the conversions are consistent.
#
use DateTime::Calendar::FrenchRevolutionary;
use DateTime;

sub check {
  my ($n, $y, $m, $d, $H, $M, $S) = @_;
  my $date_g1  = DateTime->new(year => $y, month => $m, day => $d
				, hour => $H, minute => $M, second => $S);
  my $date_rev = DateTime::Calendar::FrenchRevolutionary->from_object(object => $date_g1);
  my $date_g2  = DateTime->from_object(object => $date_rev);
  if ($date_g1 eq $date_g2)
    { print "ok $n\n" }
  else
    { print "not ok $n : expected $date_g1, got $date_g2\n" }
}

@tests = ([1789, 7, 14, 16, 15, 0] # Storming of the Bastille
	, [1515, 9, 13,  8, 30, 0] # Battle of Marignan
	, [1792, 9, 21,  8, 30, 0] # 1 day before the DT-C-FR epoch
	, [1792, 9, 22,  8, 30, 0] # the DT-C-FR epoch
);
printf "1..%d\n", scalar @tests;
my $n = 1;

foreach (@tests) { check $n++, @$_ }
