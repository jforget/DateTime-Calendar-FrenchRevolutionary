#
# Checking the (lack of) support of time zones
# It is noon in Paris, several people around the world simultaneously want to know
# which time it is.
use DateTime::Calendar::FrenchRevolutionary;
use DateTime;

sub g2r {
  my ($n, $date_r1, $tz) = @_;
  my $format = "%Y %m %d %H %M %S";
  my $date_g = DateTime->new(year => 2003, month => 4, day => 18, 
			hour => 12, minute => 0, second => 0, time_zone => 'Europe/Paris');
  $date_g->set_time_zone($tz);
  my $date_result = DateTime::Calendar::FrenchRevolutionary->from_object(object => $date_g)
                             ->strftime($format);
  my $date_r2 = $date_r1; # Alternate date to check agains, because there may be a rounding error
  substr($date_r2, -2, 2) ++; # add 1 second to alternate date, hoping we do not increment 99 to 100
  if ($date_result eq $date_r1 or $date_result eq $date_r2)
    { print "ok $n\n" }
  else
    { print "not ok $n : expected $date_r1, got $date_result\n" }
}

my @tests = (["0211 07 29 5 00 00", "Europe/Paris"]
           , ["0211 07 29 5 83 33", "Europe/Moscow"]     # offset +2 ABT hours, 83.33 d-minutes
           , ["0211 07 29 4 58 33", "Europe/London"]     # offest -1 ABT hour, -41.67 d-minutes
           , ["0211 07 29 2 08 33", "America/Chicago"]   #  -7 ABT hours, -291.67 d-minutes
           , ["0211 07 29 9 16 66", "Pacific/Auckland"]  #  10 ABT hours, -416.67 d-minutes
           , ["0211 07 29 0 00 00", "Pacific/Tahiti"]    # -12 ABT hours, -500    d-minutes
           , ["0211 07 28 9 58 33", "Pacific/Pago_Pago"] # -13 ABT hours, -541.67 d-minutes
	     );

my $nb_tests = @tests;
my $n = 1;

print "1..$nb_tests\n";

foreach (@tests) { g2r $n++, @$_ }
