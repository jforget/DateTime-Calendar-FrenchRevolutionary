use DateTime::Calendar::FrenchRevolutionary;


#my $nb_tests = @tests;
my $n = 1;
my $nb_tests = 1;

print "1..$nb_tests\n";

# Testing the epoch
# The 1e9 wraparound was on 9 September 2001, 01:46:40, that is,
# 23 Fructidor CCIX, 0:74:07
my $d = DateTime::Calendar::FrenchRevolutionary->from_epoch(epoch => 1_000_000_000);
if ($d->year == 209 && $d->month == 12 && $d->day == 23 && $d->hour == 0
     && $d->minute == 74 && $d->second >= 6 && $d->second <= 8)
  { print "ok 1\n" }
else
  { print "not ok 1, got ", $d->strftime("%Y %m %d %H %M %S%n") }

