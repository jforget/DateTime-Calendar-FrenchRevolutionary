use DateTime::Calendar::FrenchRevolutionary;
use DateTime;

# Empty class test:
package dtcfr;
use base 'DateTime::Calendar::FrenchRevolutionary';
package dt;
use base 'DateTime';
package main;

my $n = 1;

# Using the regular classes
sub g2r {
  my ($n, $date_r, $format, $y, $m, $d) = @_;
  my $date_g = DateTime->new(year => $y, month => $m, day => $d);
  my $date_resul = DateTime::Calendar::FrenchRevolutionary->from_object(object => $date_g)->strftime($format);
  if ($date_r eq $date_resul)
    { print "ok $n\n" }
  else
    { print "not ok $n : expected $date_r, got $date_resul\n" }
}

# Using the empty classes
sub g2r_em {
  my ($n, $date_r, $format, $y, $m, $d) = @_;
  my $date_g = dt::->new(year => $y, month => $m, day => $d);
  my $date_resul = dtcfr::->from_object(object => $date_g)->strftime($format);
  if ($date_r eq $date_resul)
    { print "ok $n\n" }
  else
    { print "not ok $n : expected $date_r, got $date_resul\n" }
}

@tests = ([" 1 Vendémiaire I",    "%e %B %EY", 1792,  9, 22],
	  [" 2 Brumaire II",      "%e %B %EY", 1793, 10, 23],
	  [" 9 Thermidor II",     "%e %B %EY", 1794,  7, 27],
	  [" 3 Frimaire III",     "%e %B %EY", 1794, 11, 23],
	  ["13 Vendémiaire IV",   "%e %B %EY", 1795, 10,  5],
	  [" 4 Nivôse IV",        "%e %B %EY", 1795, 12, 25],
	  [" 5 Pluviôse V",       "%e %B %EY", 1797,  1, 24],
	  [" 6 Ventôse VI",       "%e %B %EY", 1798,  2, 24],
	  ["18 Brumaire VIII",    "%e %B %EY", 1799, 11,  9],
	  [" 8 Germinal IX",      "%e %B %EY", 1801,  3, 29],
	  ["10 Floréal XII",      "%e %B %EY", 1804,  4, 30],
	  ["12 Prairial XV",      "%e %B %EY", 1807,  6,  1],
	  ["14 Messidor XVIII",   "%e %B %EY", 1810,  7,  3],
	  ["16 Thermidor XXI",    "%e %B %EY", 1813,  8,  4],
	  ["18 Fructidor XXIV",   "%e %B %EY", 1816,  9,  4],
	  ["12 Nivôse CCVIII",    "%e %B %EY", 2000,  1,  1], # Y2K compatible?
	  ["22 Floréal CCIX",     "%e %B %EY", 2001,  5, 11],
	  );

printf "1..%d\n", 2 * scalar @tests;

foreach (@tests) { g2r    $n++, @$_ }
foreach (@tests) { g2r_em $n++, @$_ }

