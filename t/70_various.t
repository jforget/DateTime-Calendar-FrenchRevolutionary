use DateTime::Calendar::FrenchRevolutionary;


#my $nb_tests = @tests;
my $n = 1;
my $nb_tests = 12;

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

# Testing the locales
my $lo;
eval { $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 locale => 'fr') };
if ($@ eq '' && $d->strftime("%A %d %B %Y") eq "Octidi 18 Brumaire 0008")
  { print "ok 3\n" }
elsif ($@)
  { print "not ok 3, error $@\n" }
else
  { printf "not ok 3, result %s\n", $d->strftime("%A %d %B %Y") }

eval { $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 locale => 'en') };
if ($@ eq '' && $d->strftime("%A %d %B %Y") eq "Eightday 18 Fogarious 0008")
  { print "ok 4\n" }
elsif ($@)
  { print "not ok 4, error $@\n" }
else
  { printf "not ok 4, result %s\n", $d->strftime("%A %d %B %Y") }

eval {
 $lo = DateTime::Calendar::FrenchRevolutionary::Locale->load('fr');
 $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 locale => $lo) };
if ($@ eq '' && $d->strftime("%A %d %B %Y") eq "Octidi 18 Brumaire 0008")
  { print "ok 5\n" }
elsif ($@)
  { print "not ok 5, error $@\n" }
else
  { printf "not ok 5, result %s\n", $d->strftime("%A %d %B %Y") }

eval {
 $lo = DateTime::Calendar::FrenchRevolutionary::Locale->load('en');
 $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 locale => $lo) };
if ($@ eq '' && $d->strftime("%A %d %B %Y") eq "Eightday 18 Fogarious 0008")
  { print "ok 6\n" }
elsif ($@)
  { print "not ok 6, error $@\n" }
else
  { printf "not ok 6, result %s\n", $d->strftime("%A %d %B %Y") }

eval { $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 locale => 'de') };
if ($@)
  { print "ok 7\n" }
else
  { print "not ok 7, unexpected success with locale 'de'\n" }

eval {
 $lo = DateTime::Calendar::FrenchRevolutionary::Locale->load('de');
 $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 locale => $lo) };
if ($@)
  { print "ok 8\n" }
else
  { print "not ok 8, unexpected success with locale 'de'\n" }

# Testing the timezones
my $tz;

eval { $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 time_zone => 'floating') };
if ($@ eq '' && $d->strftime("%A %d %B %Y") eq "Octidi 18 Brumaire 0008")
  { print "ok 9\n" }
elsif ($@)
  { print "not ok 9, error $@\n" }
else
  { printf "not ok 9, result %s\n", $d->strftime("%A %d %B %Y") }

$tz = DateTime::TimeZone->new(name => "floating");
eval { $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 time_zone => $tz) };
if ($@ eq '' && $d->strftime("%A %d %B %Y") eq "Octidi 18 Brumaire 0008")
  { print "ok 10\n" }
elsif ($@)
  { print "not ok 10, error $@\n" }
else
  { printf "not ok 10, result %s\n", $d->strftime("%A %d %B %Y") }

eval { $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 time_zone => 'Europe/Paris') };
if ($@)
  { print "ok 11\n" }
else
  { printf "not ok 11, unexpected success with time zone Paris\n" }

$tz = DateTime::TimeZone->new(name => "Europe/Paris");
eval { $d = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
 time_zone => $tz) };
if ($@)
  { print "ok 12\n" }
else
  { printf "not ok 12, unexpected success with time zone Paris\n" }

