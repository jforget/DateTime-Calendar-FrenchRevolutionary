use DateTime::Calendar::FrenchRevolutionary;


#my $nb_tests = @tests;
my $n = 1;
my $nb_tests = 2;

print "1..$nb_tests\n";

# Testing the epoch
# The 1e9 wraparound was on 9 September 2001, 01:46:40, that is,
# 23 Fructidor CCIX, 0:74:07 (plus or minus 1 second)
my $d = DateTime::Calendar::FrenchRevolutionary->from_epoch(epoch => 1_000_000_000);
if ($d->year == 209 && $d->month == 12 && $d->day == 23 && $d->hour == 0
     && $d->minute == 74 && $d->second >= 6 && $d->second <= 8)
  { print "ok 1\n" }
else
  { print "not ok 1, got ", $d->strftime("%Y %m %d %H %M %S%n") }

# Testing the nanoseconds
my $d1 = DateTime->new(year => 2003, month => 12, day => 4,
           hour => 12, minute => 30, second => 45, nanosecond => 123456789);
my $d2 = DateTime::Calendar::FrenchRevolutionary->from_object(object => $d1);
my $d3 = DateTime->from_object(object => $d2);
if ($d1->nanosecond == $d3->nanosecond)
  { print "ok 2\n" }
else
  { print "not ok 2, got ", $d3->nanosecond }
