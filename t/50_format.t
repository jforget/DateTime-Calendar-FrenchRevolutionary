use DateTime::Calendar::FrenchRevolutionary;
use DateTime;

sub g2r {
  my ($n, $date_r, $format, $y, $m, $d) = @_;
  my $date_g = DateTime->new(year => $y, month => $m, day => $d);
  my $date_resul = DateTime::Calendar::FrenchRevolutionary->from_object(object => $date_g)->strftime($format);
  if ($date_r eq $date_resul)
    { print "ok $n\n" }
  else
    { print "not ok $n : expected $date_r, got $date_resul\n" }
}

sub g2r_en {
  my ($n, $date_r, $format, $y, $m, $d) = @_;
  my $date_g = DateTime->new(year => $y, month => $m, day => $d);
  my $date_resul = DateTime::Calendar::FrenchRevolutionary->from_object(object => $date_g)->set(locale => 'en')->strftime($format);
  if ($date_r eq $date_resul)
    { print "ok $n\n" }
  else
    { print "not ok $n : expected $date_r, got $date_resul\n" }
}

my @tests = (["Nonidi 09 Thermidor II", "%A %d %B %EY", 1794,  7, 27],
	     ["Oct 18 Bru 0008",  "%a %d %b %Y", 1799, 11,  9],
	     ["0008",                      "%Y", 1799, 11,  9],
	     ["%Y",                       "%%Y", 1799, 11,  9],
	     ["%0008",                   "%%%Y", 1799, 11,  9],
	     ["%%Y",                    "%%%%Y", 1799, 11,  9],
	     ["13 Vnd, potiron",   "%d %b, %Oj", 1797, 10,  4],
	     # Groundhog day? No, jour de l'avelinier
	     ["14 Plu, jour de l'avelinier 0209", "%d %b, %Ej %Y", 2001,  2,  2],
	     ["14 Plu, Jour de l'Avelinier 0209", "%e %h, %EJ %G", 2001,  2,  2],
	     ["14 Pluviôse, avelinier 0209",      "%e %B, %Oj %L", 2001,  2,  2],
["Qua 14 Germinal CCIX, jour du hêtre", "%a %d %B %EY, %Ej", 2001, 4, 3],
["Primidi 11 Vendémiaire ccix, Jour de la Pomme de terre", "%A %d %B %Ey, %EJ", 2000, 10, 2],
[" 5 jour complémentaire 09, Jour des Récompenses", "%e %B %y, %EJ", 2001, 9, 21],
["mois : 02  2, jour 046, jour du chervis", "mois : %m %f, jour %j, %Ej", 2000, 11, 6],
["6 (Sextidi), jour de la bagarade", "%w (%A), %Ej", 2001, 9, 12],
	     );

my @tests_en = (["Nineday 09 Heatidor II", "%A %d %B %EY", 1794,  7, 27],
["Firsday 11 Vintagearious ccix, Potato Day", "%A %d %B %Ey, %EJ", 2000, 10, 2],
[" 5 additional day 09, Rewards Day", "%e %B %y, %EJ", 2001, 9, 21],
	     );

my $nb_tests = @tests + @tests_en;
my $n = 1;

print "1..$nb_tests\n";

foreach (@tests   ) { g2r    $n++, @$_ }
foreach (@tests_en) { g2r_en $n++, @$_ }
