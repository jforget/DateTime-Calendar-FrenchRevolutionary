use DateTime::Calendar::FrenchRevolutionary;


#my $nb_tests = @tests;
my $n = 1;
my $nb_tests = 1;

print "1..$nb_tests\n";

# Testing the now constructor
# You should not run this test script around midnight

my $d1 = DateTime->today;
my $d2 = DateTime::Calendar::FrenchRevolutionary->now;
my $d3 = DateTime::Calendar::FrenchRevolutionary->from_object(object => $d1);

if ($d2->strftime("%Y-%m-%d") eq $d3->strftime("%Y-%m-%d"))
  { print "ok 1\n" }
else
  { print "not ok 1, got ", $d2->strftime("%Y-%m-%d"), ' and ', $d3->strftime("%Y-%m-%d") }
