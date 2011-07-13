use DateTime::Calendar::FrenchRevolutionary;

my %years = qw/ 1 0  2 0  3 1  4 0  5 0  6 0  7 1  8 0  9 0 10 0
               11 1 12 0 13 0 14 0 15 1 16 0 17 0 18 0 19 0 20 1
               21 0 22 0 23 0 24 1 25 0 26 0 27 0 28 1 29 0 30 0
                100 0  200 0  300 0  400 1  500 0  600 0  700 0  800 1
               1000 0 2000 1 3000 0 4000 0 5000 0 6000 1 7000 0 8000 0
              /;
my $nb_tests = keys %years;

my $n = 1;

print "1..$nb_tests\n";

for my $y (sort { $a <=> $b } keys %years) {
  my $d = DateTime::Calendar::FrenchRevolutionary->new(year => $y, month => 1, day => 1);
  if ($d->is_leap_year == $years{$y}) {
    print "ok ", $n++, "\n";
  }
  else {
    print "not ok ", $n++, ", year $y wrong\n";
  }
}
