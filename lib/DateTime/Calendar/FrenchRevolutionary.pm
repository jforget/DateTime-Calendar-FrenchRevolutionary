package DateTime::Calendar::FrenchRevolutionary;

use strict;

use vars qw($VERSION);

$VERSION = '0.06';

use Params::Validate qw(validate SCALAR BOOLEAN OBJECT);
use Roman;
use DateTime;
use DateTime::Calendar::FrenchRevolutionary::Locale;

my $BasicValidate =
    { year   => { type => SCALAR },
      month  => { type => SCALAR, default => 1,
                  callbacks =>
                  { 'is between 1 and 13' =>
                    sub { $_[0] >= 1 && $_[0] <= 13 }
                  },
                },
      day    => { type => SCALAR, default => 1,
                  callbacks =>
                  { 'is between 1 and 30' =>
                    sub { $_[0] >= 1 && $_[0] <= 30 },
                  },
                },
      hour   => { type => SCALAR, default => 0,
                  callbacks =>
                  { 'is between 0 and 9' =>
                    sub { $_[0] >= 0 && $_[0] <= 9 },
                  },
                },
      minute => { type => SCALAR, default => 0,
                  callbacks =>
                  { 'is between 0 and 99' =>
                    sub { $_[0] >= 0 && $_[0] <= 99 },
                  },
                },
      second => { type => SCALAR, default => 0,
                  callbacks =>
                  { 'is between 0 and 99' =>
                    sub { $_[0] >= 0 && $_[0] <= 99 },
                  },
                },
      abt_hour   => { type => SCALAR, default => 0,
                  callbacks =>
                  { 'is between 0 and 23' =>
                    sub { $_[0] >= 0 && $_[0] <= 23 },
                  },
                },
      abt_minute => { type => SCALAR, default => 0,
                  callbacks =>
                  { 'is between 0 and 59' =>
                    sub { $_[0] >= 0 && $_[0] <= 59 },
                  },
                },
      abt_second => { type => SCALAR, default => 0,
                  callbacks =>
                  { 'is between 0 and 61' =>
                    sub { $_[0] >= 0 && $_[0] <= 61 },
                  },
                },
      nanosecond => { type => SCALAR, default => 0,
                      callbacks =>
                      { 'cannot be negative' =>
                        sub { $_[0] >= 0 },
                      }
                    },
      locale    => { type => SCALAR | OBJECT,
                     default => undef },
      language  => { type => SCALAR | OBJECT,
                     optional => 1 },
    };

my $NewValidate =
    { %$BasicValidate,
      time_zone => { type => SCALAR | OBJECT,
                     default => 'floating' },
    };
# Constructors
sub new {
    my $class = shift;
    my %args = validate( @_, $NewValidate );

    my $self = {};

    $self->{tz} = DateTime::TimeZone->new(name => 'floating');
    $args{locale} = delete $args{language} if exists $args{language};
    $args{locale} = $class->DefaultLocale unless defined $args{locale};
    if ( ref $args{locale} )
      { $self->{locale} = $args{locale} }
    else
      { $self->{locale} = DateTime::Calendar::FrenchRevolutionary::Locale->load( $args{locale} ) }

    $self->{local_rd_days} = $class->_ymd2rd(@args{qw(year month day)});
    my $abtsecs = $class->_time_as_abt_seconds(@args{qw(abt_hour abt_minute abt_second)});
    my $decsecs = $class->_time_as_seconds(@args{qw(hour minute second)});
    warn("You cannot specify both 24x60x60 time and 10x100x100 time when initializing a date")
        if $^W && $abtsecs && $decsecs;
    # We prefer decimal time over Anglo-Babylonian time when initializing a date
    $self->{local_rd_secs} = $decsecs ? $decsecs : $abtsecs;
    $self->{rd_nano} =  $args{nanosecond};

    bless $self, $class;
    $self->_calc_local_components;
    $self->_calc_utc_rd;

    return $self;
}

sub from_epoch {
  my $class = shift;
  my %args = validate( @_,
                         { epoch => { type => SCALAR },
                          locale => { type => SCALAR | OBJECT,
                                      default => $class->DefaultLocale },

                         }
                       );

  my $date = DateTime->from_epoch(%args);
  return $class->from_object(object => $date);
}

# use scalar time in case someone's loaded Time::Piece
sub now { shift->from_epoch(epoch => (scalar time), @_) }

sub from_object {
  my $class = shift;
  my %args = validate(@_,
                         { object => { type => OBJECT,
                                       can => 'utc_rd_values',
                                     },
                           locale => { type => SCALAR | OBJECT,
                                      default => $class->DefaultLocale },
                         },
                       );

  my $object = delete $args{object};
  $object = $object->clone->set_time_zone('floating')
      if $object->can('set_time_zone');

  my ($rd_days, $rd_secs, $rd_nano) = $object->utc_rd_values;

  my %p;
  @p{ qw(year  month   day) }     = $class->_rd2ymd($rd_days);
  # ABT seconds preferred over decimal seconds, because of precision loss
  @p{ qw(abt_hour  abt_minute  abt_second) }  = $class->_abt_seconds_as_components($rd_secs);
  # nanoseconds are copied, never converted ABT to decimal or reverse
  $p{nanosecond} = $rd_nano || 0;
  #@p{ qw(hour minute second) } = $class->_seconds_as_components($rd_secs);

  my $new = $class->new(%p, %args, time_zone => 'floating');

  return $new;
}

sub last_day_of_month {
    my $class = shift;
    my %p = validate( @_,
                      { year   => { type => SCALAR },
                        month  => { type => SCALAR },
                        abt_hour   => { type => SCALAR, optional => 1 },
                        abt_minute => { type => SCALAR, optional => 1 },
                        abt_second => { type => SCALAR, optional => 1 },
                        locale     => { type => SCALAR | OBJECT, optional => 1 },
                        time_zone  => { type => SCALAR | OBJECT, optional => 1 },
                      }
                    );
    my $day = $p{month} <= 12 ? 30 : $class->_is_leap_year($p{year}) ? 6 : 5;
    return $class->new(%p, day => $day);
}

sub clone { bless { %{ $_[0] } }, ref $_[0] }

# Many of the same parameters as new() but all of them are optional,
# and there are no defaults.
my $SetValidate =
    { map { my %copy = %{ $BasicValidate->{$_} };
            delete $copy{default};
            $copy{optional} = 1;
            $_ => \%copy }
      keys %$BasicValidate };
sub set
{
    my $self = shift;
    my %p = validate( @_, $SetValidate );

    my %old_p =
        ( map { $_ => $self->$_() }
          qw( year month day hour minute second nanosecond locale )
        );

    my $new_dt = (ref $self)->new( %old_p, %p );

    %$self = %$new_dt;

    return $self;
}

# Internal functions
use constant REV_BEGINNING => 654415; # RD value for 1 Vendémiaire I in the Revolutionary calendar
use constant NORMAL_YEAR    => 365;
use constant LEAP_YEAR      => 366;
use constant FOUR_YEARS     =>  4 * NORMAL_YEAR + 1; # one leap year every four years
use constant CENTURY        => 25 * FOUR_YEARS - 1;  # centuries aren't leap years...
use constant FOUR_CENTURIES =>  4 * CENTURY + 1;     # ...except every four centuries that are.
use constant FOUR_MILLENIA  => 10 * FOUR_CENTURIES - 1; # ...except every four millenia that are not.

# number of days between the start of the revolutionary calendar, and the
# beginning of year n - 1 as long as the equinox rule is in effect
my @YEARS_BEGINS=    (0, 365, 730, 1096, 1461, 1826, 2191, 2557, 2922, 3287, 3652,
		   4018, 4383, 4748, 5113, 5479, 5844);
sub _is_leap_year {
    my ($self, $year) = @_;

    # Autumn equinox from I to XIX
    return 1 if ($year == 3) or ($year == 7) or ($year == 11) or ($year == 15);
    return 0 if ($year < 20);

    # Romme rule from XX on
    return 0 if $year %    4; # not a multiple of 4 -> normal year
    return 1 if $year %  100; # a multiple of 4 but not of 100 is a leap year
    return 0 if $year %  400; # a multiple of 100 but not of 400 is a normal year
    return 1 if $year % 4000; # a multiple of 400 but not of 4000 is leap
    return 0; # a multiple of 4000 is a normal year
}

sub _calc_utc_rd {
  my $self = shift;

  delete $self->{utc_c};

  if ($self->{tz}->is_utc)
    {
      $self->{utc_rd_days} = $self->{local_rd_days};
      $self->{utc_rd_secs} = $self->{local_rd_secs};
      return;
    }

  $self->{utc_rd_days} = $self->{local_rd_days};
  $self->{utc_rd_secs} = $self->{local_rd_secs} - $self->_offset_from_local_time;
  _normalize_seconds($self->{utc_rd_days}, $self->{utc_rd_secs}, $self->{rd_nano});
}

sub _calc_local_rd {
  my $self = shift;

  delete $self->{local_c};

  # We must short circuit for UTC times or else we could end up with
  # loops between DateTime.pm and DateTime::TimeZone
  if ($self->{tz}->is_utc)
    {
      $self->{local_rd_days} = $self->{utc_rd_days};
      $self->{local_rd_secs} = $self->{utc_rd_secs};
    }
   else
    {
      $self->{local_rd_days} = $self->{utc_rd_days};
      $self->{local_rd_secs} = $self->{utc_rd_secs} + $self->offset;
      _normalize_seconds($self->{local_rd_days}, $self->{local_rd_secs});
    }

    $self->_calc_local_components;
}

sub _normalize_seconds {
  my ($d, $s) = @_;
  my $adj;
  if ($s < 0)
    { $adj = int(($s - 86399) / 86400) }
  else
    { $adj = int($s / 86400) }
  $_[0] += $adj;
  $_[1] -= $adj * 86400;
}

sub _calc_local_components {
  my $self = shift;
  @{ $self->{local_c} }{ qw(year month day day_of_decade day_of_year) } 
        = $self->_rd2ymd($self->{local_rd_days}, 1);
  @{ $self->{local_c} }{ qw(abt_hour abt_minute abt_second) }
        = $self->_abt_seconds_as_components($self->{local_rd_secs});
  @{ $self->{local_c} }{ qw(hour minute second) }
        = $self->_seconds_as_components($self->{local_rd_secs});
}

sub _calc_utc_components {
  my $self = shift;
  @{ $self->{utc_c} }{ qw(year month day) } = $self->_rd2ymd($self->{utc_rd_days});
  @{ $self->{utc_c} }{ qw(abt_hour abt_minute abt_second) }
          = $self->_abt_seconds_as_components($self->{utc_rd_secs});
  @{ $self->{utc_c} }{ qw(hour minute second) } 
          = $self->_seconds_as_components($self->{utc_rd_secs});
}

sub _ymd2rd {
    my ($self, $y, $m, $d) = @_;
    my $rd = REV_BEGINNING - 1; # minus 1 for the zeroth Vendémiaire
    $y --;  #get years *before* this year.  Makes math easier.  :)
    # first, convert year into days. . .
    if ($y < 0 || $y >= 16) # Romme rule in effect, or nearly so
      {
        my $x = int($y/4000);
        --$x if $y <= 0;
	$rd += $x * FOUR_MILLENIA;
	$y  %= 4000;
	$rd += int($y/400)* FOUR_CENTURIES;
	$y  %= 400;
	$rd += int($y/100)* CENTURY;
	$y  %= 100;
	$rd += int($y/4)* FOUR_YEARS;
	$y  %= 4;
	$rd += $y * NORMAL_YEAR;
      }
    else # table look-up for the programmer-hostile equinox rule
      {	$rd += $YEARS_BEGINS[$y] }

    # now, month into days.
    $rd += 30 * ($m - 1) + $d;
    return $rd;
}

sub _rd2ymd {
    my ($self, $rd, $extra) = @_;

    my $doy;
    my $y;
    # note:  years and days are initially days *before* today, rather than
    # today's date.  This is because of fenceposts.  :)
    $doy =  $rd - REV_BEGINNING;
    if ($doy >= 0 && $doy < $YEARS_BEGINS[16])
      {
       	$y = scalar grep { $_ <= $doy } @YEARS_BEGINS;
	$doy -= $YEARS_BEGINS[$y - 1];
	$doy++;
      }
    else
      {
	#$doy --;
	my $x;
	$x    = int ($doy / FOUR_MILLENIA);
        --$x  if $doy < 0; # So pre-1792 dates will give something that look about right
        $y   += $x * 4000;
	$doy -= $x * FOUR_MILLENIA;

	$x    = int ($doy / FOUR_CENTURIES);
        $y   += $x * 400;
	$doy -= $x * FOUR_CENTURIES;

	$x    = int ($doy / CENTURY);
        $x    = 3 if $x == 4; # last day of the 400-year period; see comment below
        $y   += $x * 100;
	$doy -= $x * CENTURY;

	$x    = int ($doy / FOUR_YEARS);
        $y   += $x * 4;
	$doy -= $x * FOUR_YEARS;

	$x    = int ($doy / NORMAL_YEAR);
        # The division above divides the 4-year period, 1461 days,
        # into 5 parts: 365, 365, 365, 365 and 1. This mathematically sound operation
        # is wrong with respect to the calendar, which needs to divide
        # into 4 parts: 365, 365, 365 and 366. Therefore the adjustment below.
        $x    = 3 if $x == 4; # last day of the 4-year period
        $y   += $x;
	$doy -= $x * NORMAL_YEAR;

        ++$y; # because of 0-based mathematics vs 1-based chronology
        ++$doy;
      }
    my $d  = $doy % 30 || 30;
    my $m = ($doy - $d) / 30 + 1;
    if ($extra)
      {
        # day_of_decade, day_of_year
        my $dod = ($d % 10) || 10;
        return $y, $m, $d, $dod, $doy;
      }
    return $y, $m, $d;
}

# Aliases provided for compatibility with DateTime; if DateTime switches
# over to _ymd2rd and _rd2ymd, these will be removed eventually.
*_greg2rd = \&_ymd2rd;
*_rd2greg = \&_rd2ymd;

#
# Accessors
#
sub year    { $_[0]->{local_c}{year} }

sub month   { $_[0]->{local_c}{month} }
*mon = \&month;

sub month_0 { $_[0]->{local_c}{month} - 1 };
*mon_0 = \&month_0;

sub month_name {
    my $self = shift;
    return $self->{locale}->month_name($self);
    #return $months[$self->month_0]
}

sub month_abbr {
    my $self = shift;
    return $self->{locale}->month_abbreviation($self);
    #return $months_short[$self->month_0]
}

sub day_of_month { $_[0]->{local_c}{day} }
*day  = \&day_of_month;
*mday = \&day_of_month;

sub day_of_month_0 { $_[0]->{local_c}{day} - 1 }
*day_0  = \&day_of_month_0;
*mday_0 = \&day_of_month_0;

sub day_of_decade { $_[0]->{local_c}{day} % 10 || 10 }
*dod  = \&day_of_decade;

sub day_of_decade_0 { ($_[0]->{local_c}{day} - 1) % 10 }
*dod_0  = \&day_of_decade_0;

sub day_name {
    my $self = shift;
    return $self->{locale}->day_name($self);
    #return $decade_days[$self->day_of_decade_0];
}

sub day_abbr {
    my $self = shift;
    return $self->{locale}->day_abbreviation($self);
    #return $decade_days_short[$self->day_of_decade_0];
}

sub day_of_year { $_[0]->{local_c}{day_of_year} }
*doy = \&day_of_year;

sub day_of_year_0 { $_[0]->{local_c}{day_of_year} - 1 }
*doy_0 = \&day_of_year_0;

sub feast_short {
  my ($dt) = @_;
  return $dt->{locale}->feast_short($dt);
}
*feast = \&feast_short;

sub feast_long {
  my ($dt) = @_;
  return $dt->{locale}->feast_long($dt);
}

sub feast_caps {
  my ($dt) = @_;
  return $dt->{locale}->feast_caps($dt);
}

sub ymd {
    my ($self, $sep) = @_;
    $sep = '-' unless defined $sep;
    return sprintf("%0.4d%s%0.2d%s%0.2d",
                   $self->year, $sep,
                   $self->{local_c}{month}, $sep,
                   $self->{local_c}{day});
}
*date = \&ymd;

sub mdy {
    my ($self, $sep) = @_;
    $sep = '-' unless defined $sep;
    return sprintf("%0.2d%s%0.2d%s%0.4d",
                   $self->{local_c}{month}, $sep,
                   $self->{local_c}{day}, $sep,
                   $self->year);
}

sub dmy {
  my ($self, $sep) = @_;
  $sep = '-' unless defined $sep;
  return sprintf("%0.2d%s%0.2d%s%0.4d",
                 $self->{local_c}{day}, $sep,
                 $self->{local_c}{month}, $sep,
                 $self->year);
}

# Anglo-Babylonian (or sexagesimal) time
sub abt_hour   { $_[0]->{local_c}{abt_hour} }
sub abt_minute { $_[0]->{local_c}{abt_minute} } *abt_min = \&abt_minute;
sub abt_second { $_[0]->{local_c}{abt_second} } *abt_sec = \&abt_second;
sub abt_hms {
  my ($self, $sep) = @_;
  $sep = ':' unless defined $sep;
  return sprintf("%0.2d%s%0.2d%s%0.2d",
                    $self->{local_c}{abt_hour}, $sep,
                    $self->{local_c}{abt_minute}, $sep,
                    $self->{local_c}{abt_second});
}

sub nanosecond { $_[0]->{rd_nano} }

# Decimal time
sub hour   { $_[0]->{local_c}{hour} }
sub minute { $_[0]->{local_c}{minute} } *min = \&minute;
sub second { $_[0]->{local_c}{second} } *sec = \&second;

sub hms {
    my ($self, $sep) = @_;
    $sep = ':' unless defined $sep;
    return sprintf("%0.1d%s%0.2d%s%0.2d",
                    $self->{local_c}{hour}, $sep,
                    $self->{local_c}{minute}, $sep,
                    $self->{local_c}{second} );
}
# don't want to override CORE::time()
*DateTime::Calendar::FrenchRevolutionary::time = \&hms;

sub iso8601 {
  my $self = shift;
  return join 'T', $self->ymd, $self->hms(':');
}
*datetime = \&iso8601;

sub is_leap_year { $_[0]->_is_leap_year($_[0]->year) }

sub decade {
  my $self = shift;
  return 3 * $self->month + int(($self->day - 1) / 10) - 2;
}
*decade_number = \&decade;

#sub time_zone { $_[0]->{tz} }

sub offset { $_[0]->{tz}->offset_for_datetime($_[0]) }
sub _offset_from_local_time { $_[0]->{tz}->offset_for_local_datetime($_[0]) }

#sub is_dst { $_[0]->{tz}->is_dst_for_datetime($_[0]) }

#sub time_zone_short_name { $_[0]->{tz}->short_name_for_datetime($_[0]) }

sub locale { $_[0]->{locale} }

sub utc_rd_values { @{ $_[0] }{ 'utc_rd_days', 'utc_rd_secs', 'rd_nano' } }

# Anglo-Babylonian time
sub   utc_rd_as_abt_seconds    { ($_[0]->{utc_rd_days}   * 86400) + $_[0]->{utc_rd_secs} }
sub local_rd_as_abt_seconds    { ($_[0]->{local_rd_days} * 86400) + $_[0]->{local_rd_secs} }
sub    _time_as_abt_seconds    { $_[1] * 3600 + $_[2] * 60 + $_[3] }
sub _abt_seconds_as_components { int($_[1] / 3600), int($_[1] % 3600 / 60), $_[1] % 60 }

# Decimal time
sub _time_as_seconds { .864 * ($_[1] * 10000 + $_[2] * 100 + $_[3]) }
sub _seconds_as_components { 
  my $sec = $_[1] / .864; 
  int($sec / 10000), int($sec % 10000 / 100), $sec % 100 
}

# RD 1 is JD 1,721,424.5 - a simple offset
sub jd {
  my $self = shift;
  my $jd = $self->{utc_rd_days} + 1_721_424.5;
  return $jd + ($self->{utc_rd_secs} / 86400);
}

sub mjd { $_[0]->jd - + 2_400_000.5 }

my %formats = (
      'a' => sub { $_[0]->day_abbr },
      'A' => sub { $_[0]->day_name },
      'b' => sub { $_[0]->month_abbr },
      'B' => sub { $_[0]->month_name },
#      'c' => sub { $_[0]->strftime($_[0]->{locale}->preferred_datetime_format) },
      'C' => sub { int($_[0]->year / 100) },
      'd' => sub { sprintf '%02d', $_[0]->day_of_month },
      'D' => sub { $_[0]->strftime('%m/%d/%y') },
      'e' => sub { sprintf('%2d', $_[0]->day_of_month) },
      'f' => sub { sprintf('%2d', $_[0]->month) },
      'F' => sub { $_[0]->ymd('-') },
      'g' => sub { substr($_[0]->year, -2) }
      , 'G' => sub { sprintf '%04d', $_[0]->year }
      , 'h' => sub { $_[0]->month_abbr }
      , 'H' => sub { sprintf('%d', $_[0]->hour) }
      , 'I' => sub { my $h = $_[0]->hour; $h -= 5 if $h >= 5; sprintf('%d', $h) }
      , 'j' => sub { sprintf '%03d', $_[0]->day_of_year }
      , 'k' => sub { sprintf('%2d', $_[0]->hour) }
      , 'l' => sub { my $h = $_[0]->hour; $h -= 5 if $h >= 5; sprintf('%2d', $h) }
      , 'L' => sub { sprintf '%04d', $_[0]->year }
      , 'm' => sub { sprintf '%02d', $_[0]->month }
      , 'M' => sub { sprintf '%02d', $_[0]->minute }
      , 'n' => sub { "\n" } # should this be OS-sensitive?
#     , 'p' => sub {    $_[0]->{locale}->am_pm($_[0]) }
#     , 'P' => sub { lc $_[0]->{locale}->am_pm($_[0]) }
      , 'p' => sub { $_[0]->hour < 5 ? 'AM' : 'PM' }
      , 'P' => sub { $_[0]->hour < 5 ? 'am' : 'pm' }
      , 'r' => sub { $_[0]->strftime('%I:%M:%S %p') }
      , 'R' => sub { $_[0]->strftime('%H:%M') }
      , 's' => sub { $_[0]->epoch }
      , 'S' => sub { sprintf('%02d', $_[0]->second) }
      , 't' => sub { "\t" }
      , 'T' => sub { $_[0]->strftime('%H:%M:%S') }
      , 'u' => sub { sprintf '%2d', $_[0]->day_of_decade },
      , 'U' => sub { $_[0]->decade }
      , 'w' => sub { $_[0]->day_of_decade % 10 }
      , 'W' => sub { $_[0]->decade }
      , 'y' => sub { sprintf('%02d', substr( $_[0]->year, -2 )) }
      , 'Y' => sub { sprintf '%04d', $_[0]->year }
      , 'z' => sub { offset_as_string($_[0]->offset) }
      , 'Z' => sub { $_[0]->{tz}->short_name_for_datetime($_[0]) }
      , '+' => sub { '+' }
      , '%' => sub { '%' }
      , 'EY' => sub { Roman $_[0]->year }
      , 'Ey' => sub { roman $_[0]->year }
      , 'Ej' => sub { $_[0]->feast_long }
      , 'EJ' => sub { $_[0]->feast_caps }
      , 'Oj' => sub { $_[0]->feast_short }

    );

$formats{h} = $formats{b};

sub strftime {
  my $self = shift;
  # make a copy or caller's scalars get munged
  my @formats = @_;

  my @r;
  foreach my $f (@formats)
    {
      # regex from DateTime from Date::Format - thanks Graham and Dave!
      # but there is a twist: 3-char format specifiers such as '%Ey' are
      # allowed. All 3-char specifiers begin with a '%E' or '%O' prefix.
      # At the same time, if the user wants %Em or %Om, which do not exist, it defaults to %m
      # And if the user asks for %E!,
      # it defaults to E! because neither %E! nor %! exist.
      $f =~ s/
	        %([EO]?([%a-zA-Z]))
             /
                $formats{$1} ? $formats{$1}->($self)
                             : $formats{$2} ? $formats{$2}->($self) : $1
             /sgex;
      return $f unless wantarray;
      push @r, $f;
    }
  return @r;
}

sub epoch {
  my $self = shift;
  my $greg = DateTime->from_object(object => $self);
  return $greg->epoch;
}

#sub set_time_zone {
#    my ($self, $tz) = @_;
#
#    my $was_floating = $self->{tz}->is_floating;
#
#    $self->{tz} = ref $tz ? $tz : DateTime::TimeZone->new(name => $tz);
#
#    if ($self->{tz}->is_floating && ! $was_floating)
#      { $self->_calc_utc_rd }
#    elsif (!$was_floating)
#      { $self->_calc_local_rd }
#}

sub DefaultLocale {
  'fr'
}

my %events = ();
sub on_date {
  my ($dt, $lan) = @_;
  my $locale;

  if (defined $lan)
    { $locale = DateTime::Calendar::FrenchRevolutionary::Locale->load( $lan )}
  else
    { $locale = $dt->{locale} }
  return $locale->on_date($dt);

  #_load_events() unless %events;
  #$events{$self->strftime('%m%dE')} || "";
}

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
"Liberté, égalité, fraternité
ou la mort !";

__DATA__
0101E
1 Vendémiaire I The French troops enter Savoie
1 Vendémiaire III The outposts in the woods of Aachen and Reckem are
taken by the Army of North (Jourdan)
0101F
1 Vendémiaire I entrée des troupes françaises en Savoie
1 Vendémiaire III les postes du bois d'Aix-la-Chapelle et de Reckem sont enlevés 
par l'Armée du Nord (Jourdan)
0102E
2 Vendémiaire I Conquest of Chambéry
2 Vendémiaire III The  Costouge redoubt and camp are taken by the Army
of Eastern Pyrenees (Dugommier).
2 Vendémiaire V The Army of Italy (Kilmaine) routs the enemy at Governolo.
0102F
2 Vendémiaire I conquête de Chambéry
2 Vendémiaire III prise de la redoute et du camp de Costouge par l'Armée des
Pyrénées orientales (Dugommier).
2 Vendémiaire V l'Armée d'Italie (Kilmaine) met en déroute l'ennemi à Governolo.
0103E
3 Vendémiaire IV affair of Garesio (Miolis)
0103F
3 Vendémiaire IV affaire de Garesio (Miolis)
0104E
4 Vendémiaire II The Army of Alps (Verdelin) takes the entrenchments of
Chatillon; the Piemontese rout across the Giffe river
0104F
4 Vendémiaire II l'Armée des Alpes (Verdelin) enlève de vive force les retranchements
de Chatillon ; les Piémontais sont mis en déroute et repassent la rivière de Giffe.
0105E
5 Vendémiaire III The Spanish are defeated in Olia and Monteilla by the
Army of Eastern Pyrenees (Charlet).
0105F
5 Vendémiaire III défaite des Espagnols à Olia et Monteilla par l'Armée des Pyrénées
orientales (Charlet).
0106E
6 Vendémiaire III Surrender at Crevecoeur to the Army of the North (Delmas)
6 Vendémiaire III Kayserlautern, Alsborn and other surrounding outposts
are taken again by the Army of the Rhine (Michaud)
6 Vendémiaire V The enemy attacks the Armée of Sambre et Meuse (Hardy) at
Wurstatt, Nider-Ulm, Ober and  Nider-Iogelheim; the attack is repulsed.
0106F
6 Vendémiaire III capitulation de Crevecoeur devant l'Armée du Nord (Delmas)
6 Vendémiaire III reprise de Kayserlautern, d'Alsborn et autres postes environnants
par l'Armée du Rhin (Michaud)
6 Vendémiaire V l'ennemi attaque l'Armée de Sambre et Meuse (Hardy) sur les
points de Wurstatt, Nider-Ulm, Ober et Nider-Iogelheim ; l'attaque est repoussée.
0107E
7 Vendémiaire I Anselm's troops conquer the city of Nice and the  Montalban fortress. 
7 Vendémiaire II The Army of Alps (Verdelin) defeats the enemy in the  Sallanges 
defiles and takes the Saint-Martin redoubt.
0107F
7 Vendémiaire I prise de la ville de Nice et de la forteresse de Montalban 
par les troupes d'Anselme.
7 Vendémiaire II l'Armée des Alpes (Verdelin) défait l'ennemi dans les gorges
de Sallanges et prend la redoute de Saint-Martin.
0108E
8 Vendémiaire V 150 men from the Army of Italy sortie from Mantoue to forage.
They must surrender to the people of Reggio.
0108F
8 Vendémiaire V 150 hommes de l'Armée d'Italie font une sortie de Mantoue pour
se procurer du fourrage. Ils doivent se rendre aux habitants de Reggio.
0109F
9 Vendémiaire I  Custines' Frenchs conquer the Spire city after having
blown the gates with cannon and endured musketry fire in the streets.
9 Vendémiaire II The Army of Alps (Chamberlhac) takes the entrenchments at
Mont-Cormet, previously held by Piemontese.
0109F
9 Vendémiaire I les Français de Custines se rendent maîtres de la ville de Spire
après avoir enfoncé les portes à coups de canons et subi un feu de mousqueterie
dans les rues de la ville.
9 Vendémiaire II l'Armée des Alpes (Chamberlhac) enlève de vive-force les
retranchements de Mont-Cormet tenus par les Piémontais.
0111E
11 Vendémiaire II Prisy's troops (Army of Alps) take the Valmeyer outpost
after a bayonet charge, Saint-André's and Chamberlhac's troops take the Beaufort
outpost, General-in-Chief Kellerman's troops take Moutiers and the Saint-Maurice
town and Ledoyen's troops storm the Madeleine pass outpost. 
11 Vendémiaire III during the battle of Aldenhoven, the Army of Sambre-et-Meuse
(Jourdan) routs the coalised troops.
11 Vendémiaire V the Army of Rhine and Moselle (general-in-chief Moreau, 
division generals Desaix and Saint-Cyr) attacks on the whole front and routs the enemy.
0111F
11 Vendémiaire II les troupes de Prisy de l'Armée des Alpes enlèvent le poste
de Valmeyer à la bayonette, celles de Saint-André et de Chamberlhac enlèvent
le poste de Beaufort, celles du général-en-chef Kellerman prennent Moutiers et 
le bourg Saint-Maurice et celles de Ledoyen enlèvent de vive force le poste
du Col de la Madeleine.
11 Vendémiaire III à la bataille d'Aldenhoven, l'Armée de Sambre-et-Meuse
(Jourdan) provoque la déroute des troupes coalisées.
11 Vendémiaire V l'Armée du Rhin et Moselle (général-en-chef Moreau, 
généraux de division Desaix et Saint-Cyr) attaque sur toute la ligne et met
l'ennemi en déroute.
0112E
12 Vendémiaire II The Spanish troops are repulsed back in their camps in the Boulon 
and Argelès by the Army of Eastern Pyrenees (Delatre).
12 Vendémiaire III the land of Juliers surrenders to the Army of Sambre-et-Meuse (Jourdan).
0112F
12 Vendémiaire II les Espagnols sont forcés dans leurs camps du Boulon 
et Argelès par l'Armée des Pyrénées orientales (Delatre).
12 Vendémiaire III le pays de Juliers se rend à l'Armée de Sambre-et-Meuse (Jourdan).
0113E
13 Vendémiaire I the Austrians must leave the city of  Worms
and Custines' troops enter the city.
13 Vendémiaire II Army of Eastern Pyrenees : Dagobert's troops take
Campredon while the Colioure garrison (Delatre) fights and routs the Spanish cavalry.
13 Vendémiaire II arrayed in three columns (Lasalle, Mascaron and
Dat), the Army of Western Pyrenees attacks and takes the Arau and Aure
valley outposts.
13 Vendémiaire IV Bonaparte represses a royalist demonstration near Saint-Roch church
0113F
13 Vendémiaire I les Autrichiens sont forcés d'évacuer la ville de Worms
et les troupes de Custines y font leur entrée.
13 Vendémiaire II Armée des Pyrénées orientales : les troupes de Dagobert prennent
Campredon tandis que la garnison de Colioure (Delatre) combat la cavalerie espagnole
et la met en déroute.
13 Vendémiaire II l'Armée des Pyrénées occidentales attaque les postes d'Arau
et de la vallée d'Aure sur trois colonnes (Lasalle, Mascaron et Dat) et les enlève.
13 Vendémiaire IV Bonaparte réprime une manifestation royaliste à l'église Saint-Roch
0115E
15 Vendémiaire III Cologne surrenders to the Army of Sambre-et-Meuse (Jourdan).
0115F
15 Vendémiaire III Cologne se rend à l'Armée de Sambre-et-Meuse (Jourdan).
0116E
16 Vendémiaire V the enemy, blockaded in Mantoue by the Army of Italy (Sahuguet) 
attempt a  4,600-troop sortie but fails.
0116F
16 Vendémiaire V l'ennemi, bloqué à Mantoue par l'Armée d'Italie (Sahuguet) tente
une sortie de 4 600 hommes, sortie qui se solde par un échec.
0117E
17 Vendémiaire I as the French Army comes near, the  Austrians lift
the siege of Lille.
17 Vendémiaire III fight for and capture of Frankenthal by the Army of the Rhine (Desaix)
0117F
17 Vendémiaire I à l'approche de l'Armée française, les Autrichiens lèvent
précipitamment le siège de Lille.
17 Vendémiaire III combat et prise de Frankenthal par l'Armée du Rhin (Desaix)
0118E
18 Vendémiaire II bombardment of Lyon, which opens her gates to
Dubois-de-Crancé's troops.
18 Vendémiaire III capture of Shelaudenbach and Vollfstein by the Army of the Rhine (Michaud)
which links with the Army of Moselle in Lautreck.
0118F
18 Vendémiaire II bombardement de Lyon qui ouvre ses portes aux troupes de 
Dubois-de-Crancé.
18 Vendémiaire III prise de Shelaudenbach et de Vollfstein par l'Armée du Rhin (Michaud)
et jonction avec l'Armée de la Moselle à Lautreck.
0119E
19 Vendémiaire III before Maestricht, the Army of Sambre-et-Meuse (Duhesme) takes back
the  Mont-Saint-Pierre castle.
0119F
19 Vendémiaire III devant Maestricht, l'Armée de Sambre-et-Meuse (Duhesme) reprend
le château de Mont-Saint-Pierre.
0120E
20 Vendémiaire III the Army of Moselle (Moreau) marches on Birkenfeldt, Oberstein,
Kirn and Meisenheim.
0120F
20 Vendémiaire III l'Armée de la Moselle (Moreau) marche sur Birkenfeldt, Oberstein,
Kirn et Meisenheim.
0121E
21 Vendémiaire III the Army of the North (Delmas) enters in Bois-le-Duc.
0121F
21 Vendémiaire III entrée de l'Armée du Nord (Delmas) dans Bois-le-Duc.
0122E
22 Vendémiaire I Kellerman forces the Prussians to leave the city of Verdun.
He enters Verdun and continues his march to the Prussians.
0122F
22 Vendémiaire I Kellerman force les Prussiens à évacuer la ville de Verdun.
Il y entre et poursuit sa marche contre eux.
0123E
23 Vendémiaire III the Army of the Rhine (Michaud) takes Otterberg, Rockenhausen, 
Landsberg, Alzein and Oberhausen.
0123F
23 Vendémiaire III l'Armée du Rhin (Michaud) prend Otterberg, Rockenhausen, 
Landsberg, Alzein et Oberhausen.
0124E
24 Vendémiaire II the Army of Moselle (Delaunay) fights and routs the
Coalised wchich had advanced on Bitche and Rorbach.
24 Vendémiaire III fight for and capture of Gellheim and Grunstad by
the Army of the Rhine (Michaud); the Frenchs capture also Frankenthal.
0124F
24 Vendémiaire II l'Armée de la Moselle (Delaunay) combat et provoque la retraite
précipitée des coalisés qui s'étaient portés sur Bitche et Rorbach.
24 Vendémiaire III combat et prise de Gellheim et de Grunstad par 
l'Armée du Rhin (Michaud) ; les Français reprennent aussi Frankenthal.
0125E
25 Vendémiaire II combat near Sarreguemines; the Army of Moselle (Delaunay)
repulses the enemy.
0125F
25 Vendémiaire II combat près de Sarreguemines ; l'Armée de la Moselle (Delaunay)
repousse l'ennemi.
0126E
26 Vendémiaire I the Austrians attack and fail several times Hasnon
(Muller commander), they are repulsed having suffered many losses.
26 Vendémiaire II the battle of Wattignies near Maubeuge is won
by the Army of the North (Jourdan) against the Austrians and the blockade of 
Maubeuge is lifted.
26 Vendémiaire III The Army of Western Pyrenees (Moncey) takes
Iraty and the wonderful forges of Egay and Orbaycette.
26 Vendémiaire III Army of Moselle :  general-in-chief 
Moreau's troops take Creutznach and Custines' troops take Worms.
26 Vendémiaire VI Army of Italy: peace traity in Campo-Formio
near Udine between  general Bonaparte and the plenipotentiaries
of the Emperor, king of Hungary and Bohemia.
26 Vendémiaire VI congress in Rastadt to conclude peace between the 
French Republic and the German Empire.
0126F
26 Vendémiaire I les Autrichiens attaquent plusieurs fois inutilement Hasnon
(Muller commandant) et sont repoussés avec perte.
26 Vendémiaire II la bataille de Wattignies près de Maubeuge est remportée
par l'Armée du Nord (Jourdan) sur les Autrichiens et le blocus de Maubeuge est levé.
26 Vendémiaire III l'Armée des Pyrénées occidentales (Moncey) prend la belle
mâture d'Iraty et les superbes fonderies d'Egay et d'Orbaycette.
26 Vendémiaire III Armée de la Moselle : les troupes du général-en-chef 
Moreau prennent Creutznach et celles de Custines prennent Worms.
26 Vendémiaire VI Armée d'Italie : traité de paix définitif à Campo-Formio
près d'Udine entre le général Bonaparte et les plénipotentiaires de l'Empereur,
roi de Hongrie et de Bohême.
26 Vendémiaire VI congrès à Rastadt pour la conclusion de la paix entre
la République française et l'Empire germanique.
0127E
27 Vendémiaire II 600 republican troops from the Army of Italy (Dugommier) 
take a tactical advantage in  Gillette over 4,000 Austrians, Croats and Piemontese
and repulse them.
27 Vendémiaire III The Army of Western Pyrenees (Delabare) defeats 7,000 
Spaniards near Buruet and Almandos.
27 Vendémiaire III The Army of the Rhine (Michaud) routs the enemy near
Kircheim and Worms and captures both cities.
0127F
27 Vendémiaire II 600 républicains de l'Armée d'Italie (Dugommier) remportent
l'avantage à Gillette sur 4 000 Autrichiens, Croates et Piémontais et les
repoussent.
27 Vendémiaire III l'Armée des Pyrénées occidentales (Delabare) défait 7 000 
Espagnols près de Buruet et d'Almandos.
27 Vendémiaire III l'Armée du Rhin (Michaud) met en déroute l'ennemi près
de Kircheim et de Worms et prend ces deux villes.
0128E
28 Vendémiaire II The Army of Italy (Dugommier) achieves a complete
victory at Gilette over the Piemontese.
28 Vendémiaire III The Armée of the North (Souham) defeats the enemy near Nimegen
and destroys the legion of Rohan.
28 Vendémiaire V The Army of the Rhin and Moselle (general-in-chief Moreau and
division general Beaupuis) is attacked in Retzengen and Simonswald, but
the enemy efforts fail.
0128F
28 Vendémiaire II l'Armée d'Italie (Dugommier) remporte
une victoire complète à Gilette sur les Piémontais.
28 Vendémiaire III l'Armée du Nord (Souham) défait l'ennemi près de Nimègue
et détruit la légion de Rohan.
28 Vendémiaire V l'Armée du Rhin et Moselle (général-en-chef Moreau et
général de division Beaupuis) est attaquée à Retzengen et à Simonswald, les 
efforts des ennemis sont vains.
0129E
29 Vendémiaire I The French Army (general-in-chief Custines) forces the
Austrians to leave Mayence.
29 Vendémiaire III The Armée of Moselle (Moreau) enters  Bingen
after having expelled the Prussians from the positions they held before the town.
29 Vendémiaire V the Army of Italy (Casalta), debarking in Corsica, advances to
Bastia and expels the English from the fort where they had retired.
Saint-Florent and Bonifacio also captured.
0129F
29 Vendémiaire I l'Armée française (général-en-chef Custines) force les
Autrichiens à évacuer Mayence.
29 Vendémiaire III l'Armée de la Moselle (Moreau) entre dans Bingen
après avoir chassé les Prussiens des positions qu'ils tenaient en avant
de la ville.
29 Vendémiaire V l'Armée d'Italie (Casalta), débarquée en Corse, se porte
sur Bastia et chasse les Anglais qui s'étaient retirés dans le fort.
Prise également des villes de Saint-Florent et de Bonifacio.
0130E
30 Vendémiaire II the Army of Western Pyrenees (Poncet) 
routs three Spanish columns after a five-hour firefight.
30 Vendémiaire V Army of Sambre and Meuse (general-in-chief Beurnonville,
division generals Championnet and Grenier): the enemy crosses the Rhine at
six points from Bacharach up to Andernach and attacks the Neuwied bridgehead 
but is forced to retreat.
0130F
30 Vendémiaire II l'Armée des Pyrénées occidentales (Poncet) met
en déroute trois colonnes espagnoles après une fusillade de cinq heures.
30 Vendémiaire V Armée de Sambre et Meuse (général-en-chef Beurnonville,
généraux de division Championnet et Grenier) : l'ennemi passe le Rhin sur
six points depuis Bacharach jusqu'à Andernach et attaque la tête de pont
de Neuwied et est forcé à la retraite.
0218E
18 Brumaire VIII Bonaparte's coup: end of the Directoire, beginning of the Consulate
0218F
18 Brumaire VIII Coup d'état de Bonaparte : fin du Directoire, début du Consulat
0311E
11 Frimaire XIII Napoléon 1st is crowned Emperor of the French
11 Frimaire XIV Austerlitz battle: the French army crushes the Austro-Russian army
0311F
11 Frimaire XIII Napoléon Premier est couronné Empereur des Français
11 Frimaire XIV Bataille d'Austerlitz : l'armée française écrase l'armée austro-russe
0607E
7 Ventôse X Birth of Victor Hugo
0607F
7 Ventôse X Naissance de Victor Hugo
0901F
1 Prairial VII Birth of Honoré de Balzac
0901E
1 Prairial VII Naissance d'Honoré de Balzac
0925E
25 Prairial VIII Battle of Marengo in Italy, Kleber is assassinated in Cairo
0925F
25 Prairial VIII Bataille de Marengo en Italie, Kléber est assassiné au Caire
1008E
8 Messidor II Victory of Fleurus by Jourdan. First use of aerial reco, by 
Captain Coutelle in the balloon "L'Entreprenant".
1008F
8 Messidor II Victoire de Fleurus par Jourdan. Première utilisation de la
reconnaissance aérienne par le capitaine Coutelle, à bord du ballon L'Entreprenant
1103E
3 Thermidor III Victory of Hoche at Quiberon against Royalist forces
1103F
3 Thermidor III Victoire de Hoche à Quiberon contre les royalistes
1109E
9 Thermidor II Demise of Robespierre
1109F
9 Thermidor II La chute de Robespierre
1118E
18 Thermidor IV Victory of Bonaparte against Wurmser at Castiglione
1118F
18 Thermidor IV Victoire de Bonaparte sur Wurmser à Castiglione
1303E
Jour du travail V Death of General Hoche
1303F
Jour du travail V Mort du général Hoche
1305E
Jour des récompenses IV Death of General Marceau, age 27, at Altenkirchen
1305F
Jour des récompenses IV Mort du général Marceau, âgé de 27 ans, à Altenkirchen
__END__

=head1 NAME

DateTime::Calendar::FrenchRevolutionary - Dates in the French Revolutionary Calendar

=head1 SYNOPSIS

  use DateTime::Calendar::FrenchRevolutionary;

  $dt = DateTime::Calendar::FrenchRevolutionary->new( year  => 8,
                                         month =>  2,
                                         day   => 18,
                                       );

  # convert FrenchRevolutionary->Gregorian...

  $dtgreg = DateTime->from_object( object => $dt );

  # ... and back again

  $dtrev = DateTime::Calendar::FrenchRevolutionary->from_object( object => $dtgreg );

=head1 DESCRIPTION

DateTime::Calendar::FrenchRevolutionary implements the French Revolutionary
Calendar.  This module implements most methods of DateTime; see the
DateTime(3) manpage for all methods.

=head1 HISTORICAL NOTES

The Revolutionary calendar was in  use in France from 24 November 1793
(4 Frimaire  II) to 31  December 1805 (10  Nivôse XIV). An  attempt to
apply  the  decimal rule  (the  basis of  the  metric  system) to  the
calendar. Therefore, the week  disappeared, replaced by the décade (10
days, totally different from the  English word "decade", 10 years). In
addition, all months have exactly 3 decades, no more, no less.

At first,  the year was  beginning on the  equinox of autumn,  for two
reasons.  First, the  republic had  been established  on  22 September
1792, which  happened to be the  equinox, and second,  the equinox was
the symbol of equality, the day and the night lasting exactly 12 hours
each. It  was therefore  in tune with  the republic's  motto "Liberty,
Equality, Fraternity". But  it was not practical, so  Romme proposed a
leap year rule similar to the Gregorian calendar rule.

In his book I<The French Revolution>, the XIXth century writer Thomas
Carlyle proposes these translations for the month names:

=over 4

=item Vendémiaire -> Vintagearious

=item Brumaire -> Fogarious

=item Frimaire -> Frostarious

=item Nivôse -> Snowous

=item Pluviôse -> Rainous

=item Ventôse -> Windous

=item Germinal -> Buddal

=item Floréal -> Floweral

=item Prairial -> Meadowal

=item Messidor -> Reapidor

=item Thermidor -> Heatidor

=item Fructidor -> Fruitidor

=back

There was also an attempt to decimalize the day's subunits, with 1 day
= 10 hours, 1 hour = 100 minutes and 1 minute = 100 seconds.  But this
reform was put on hold after two years or so and it never reappeared.

=head1 METHODS

Since  the week  has been  replaced by  the décade,  the corresponding
method  names  still   are  C<decade_number>,  C<day_of_decade>,  etc.
English  speakers, please  note that  this has  nothing to  do  with a
10-year period.

The module supports both  Anglo-Babylonian time and decimal time.  The
accessors  for ABT are  C<abt_hour>, C<abt_minute>,  C<abt_second> and
C<abt_hms>,  the accessors  for decimal  time are  C<hour>, C<minute>,
C<second> and C<hms>. The  C<strftime> and C<iso8601> methods use only
decimal  time.  The  ABT  accessors are  provided  to be  historically
correct, since  the decimal time reform  was never put  in force. Yet,
emphasis is  on decimal time because  it is more  fun than sexagesimal
time,  which  anyhow  can  be  obtained with  the  standard  Gregorian
C<DateTime.pm> module.

=head2 Constructors

=over 4

=item * new(...)

Creates a new date object.

=item * from_epoch( epoch => $epoch )

Creates a date object from a timestamp value. This timestamp is the number of
seconds since the computer epoch, not the calendar epoch.

=item * now( )

Creates a date object that corresponds to the precise instant the 
method is called.

=item * from_object( object => $object, ... )

Creates a date object by converting another object from the DateTime suite.
The preferred way for calendar to calendar conversion.

=item * last_day_of_month( ... )

Not tested

=item * clone

Not tested

=item * set( .. )

This method can be used to change the local components of a date time,
or its locale.  This method accepts any parameter allowed by the
C<new()> method.

This method performs parameters validation just as is done in the
C<new()> method.

=back

=head2 Accessors

=over 4

=item * year

Returns the year

=item * month

Returns the month in the 1..12 range. If the date is an additional day
at the end of the year, returns 13, which is not really a month number.

=item * month_0

Returns the month in the 0..11 range. If the date is an additional day
at the end of the year, returns 12, which is not really a month number.

=item * month_name

Returns the French  name of the month. No  other language is supported
yet.  For  the additional days at  the end of the  year, returns "jour
complémentaire", the translation of "additional day".

Note: The  English translations for  the month names come  from Thomas
Carlyle's book.

=item * month_abbr

Returns  a 3-letter abbreviation of the month name. For the additional
days at the end of the year, returns "S-C", because these additional days
were also known as the I<Sans-culottides>.

=item * day_of_month, day, mday

Returns the day of the month, from 1..30.

=item * day_of_decade, dod

Returns the day of the decade, from 1..10.

=item * day_name

Returns the name of the current day of the I<décade>.

=item * day_abbr

Returns the abbreviated name of the current day of the I<décade>.

=item * day_of_year, doy

Returns the day of the year.

=item * feast, feast_short, feast_long, feast_caps

Returns the plant, animal, mineral or tool associated with the day.
The default format is C<short>. If requested, you can ask for 
the C<long> format, with a C<jour de...> prefix, or the C<caps>
format, with the first letter of the prefix and feast capitalized.
Example: for 11 Vendémiaire, we have:

   feast, feast_short  pomme de terre
   feast_long          jour de la pomme de terre
   feast_caps          Jour de la Pomme de terre

Note: the  English translation for  the feasts comes mainly  from Alan
Taylor's website "Preserving the French Republican Calendar".

=item * ymd, dmy, mdy

Returns the date in the corresponding composite format. An optional
parameter allows you to choose the separator between the date elements.

=item * abt_hour, abt_minute, abt_min, abt_second, abt_sec

Return the corresponding time elements, using a sexagesimal scale.
This is also known as the I<Anglo-Babylonian Time>.

=item * hour, minute, min, second, sec

Return the corresponding time elements, using a decimal scale,
with 10 hours per day, 100 minutes per hour and 100 seconds per minute.

=item * abt_hms

Returns a composite string with the three time elements. Uses the
I<Anglo-Babylonian Time>.  An optional parameter allows you to choose
the separator (C<:> by default).

=item * hms

Returns a composite string with the three time elements. Uses the
decimal time.  An optional parameter allows you to choose the
separator (C<:> by default).

=item * iso8601

Returns the date and time is a format similar to what ISO-8601 has
specified for the Gregorian calendar.

=item * is_leap_year

Returns a true value if the year is a leap year, false else.

=item * decade, decade_number

Returns the I<décade> number. Note: since the I<décades> are aligned
with the years, there is no need for a method giving the year of the
week... er I mean I<décade>. So the methods C<decade> and C<decade_number>
are synonymous. Especially, the C<decade> method returns a scalar, not
a 2-element list.

=item * utc_rd_values

Returns the current UTC Rata Die days and seconds as a two element
list.  This exists primarily to allow other calendar modules to create
objects based on the values provided by this object.

=item * jd, mjd

These return the Julian Day and Modified Julian Day, respectively.
The value returned is a floating point number.  The fractional portion
of the number represents the time portion of the datetime.

=item * utc_rd_as_seconds

Returns the current UTC Rata Die days and seconds purely as seconds.
This is useful when you need a single number to represent a date.

=item * local_rd_as_seconds

Returns the current local Rata Die days and seconds purely as seconds.

=item * strftime( $format, ... )

This method implements functionality similar to the C<strftime()>
method in C.  However, if given multiple format strings, then it will
return multiple elements, one for each format string.

See the L<strftime Specifiers|/strftime Specifiers> section for a list
of all possible format specifiers.

=item * epoch

Return the UTC epoch value for the datetime object.  Internally, this
is implemented using C<Time::Local>, which uses the Unix epoch even on
machines with a different epoch (such as Mac OS).  Datetimes before the
start of the epoch will be returned as a negative number.

Since epoch times cannot represent many dates on most platforms, this
method may simply return undef in some cases.

Using your system's epoch time may be error-prone, since epoch times
have such a limited range on 32-bit machines.  Additionally, the fact
that different operating systems have different epoch beginnings is
another source of bugs.

=item * on_date

Gives a few historical events that took place on the same date (day+month).
These events occur during the period of use of the calendar, that is,
no later than Gregorian year 1805. The related events either were
located in France, or were battles in which a French army was involved.

This  method accepts  one  optional argument,  the  language. For  the
moment, only  "en" for English and  "fr" for French  are available. If
not given, the method will use the date object's current locale.

Not all eligible events are portrayed there. The events database will
be expanded in future versions.

Most military events are extracted from I<Calendrier Militaire>, a book
written by an anonymous author in VII (1798) or so. I guess there is 
no longer any copyright attached. Please note that this is a propaganda
book, which therefore gives a very biased view of the events.

=back

=head2 strftime Specifiers

The following specifiers are allowed in the format string given to the
C<strftime()> method:

=over 4

=item * %a

The abbreviated day of decade name.

=item * %A

The full day of decade name.

=item * %b

The abbreviated month name, or 'S-C' for additional days (abbreviation
of I<Sans-culottide>, another name for these days).

=item * %B

The full month name.

=item * %C

The century number (year/100) as a 2-digit integer.

=item * %d

The day of the month as a decimal number (range 01 to 30).

=item * %D

Equivalent to %m/%d/%y.  This is not a good standard format if you
have want both Americans and Europeans to understand the date!

=item * %e

Like %d, the day of the month as a decimal number, but a leading zero
is replaced by a space.

=item * %F

Equivalent to %Y-%m-%d (the ISO 8601 date format)

=item * %G

Strictly similar to C<%Y>, since I<décades> are aligned with 
the beginning of the year in this calendar.

=item * %g

Strictly similar to C<%y>, since I<décades> are aligned with 
the beginning of the year in this calendar.

=item * %h

Equivalent to %b.

=item * %H

The hour as a decimal number using a 10-hour clock (range 0 to 9).
The result is a single-char string.

=item * %I

The hour as a decimal number using a 5-hour clock (range 0 to 4).
Since decimal time was never actually used, we do not know whether the 
people would have split a day in two halves. This format is provided
by analogy with the usage of sexagesimal time in the Gregorian calendar.

=item * %j

The day of the year as a decimal number (range 001 to 366).

=item * %k

The hour (10-hour clock) as a decimal number (range 0 to 9); 
the result is a 2-char string, the digit is preceded by a blank. (See also %H.)

=item * %l

The hour (5-hour clock) as a decimal number (range 1 to 4); the result
is a 2-char string, the digit is preceded by a blank. (See also %I.)

=item * %m

The month as a decimal number (range 01 to 12).

=item * %M

The minute as a decimal number (range 00 to 99).

=item * %n

A newline character.

=item * %p

Either `AM' or `PM' according to the given time value, or the
corresponding strings for the current locale.  Noon is treated as `pm'
and midnight as `am'.

=item * %P

Like %p but in lowercase: `am' or `pm' or a corresponding string for
the current locale.

=item * %r

The decimal time in a.m.  or p.m. notation.  In the POSIX locale this is
equivalent to `%I:%M:%S %p'.

=item * %R

The decimal time in 10-hour notation (%H:%M). (SU) For a version including the
seconds, see %T below.

=item * %s

The number of seconds since the epoch.

=item * %S

The second as a decimal number (range 00 to 99).

=item * %t

A tab character.

=item * %T

The decimal time in 10-hour notation (%H:%M:%S).

=item * %u

The day of the I<décade> as a decimal, range 1 to 10, Primidi being 1.  See
also %w.

=item * %U

The I<décade> number of the current year as a decimal number, range 00
to 31.

=item * %V

to be adapted to FR calendar.
The ISO 8601:1988 week number of the current year as a decimal number,
range 01 to 53, where week 1 is the first week that has at least 4
days in the current year, and with Monday as the first day of the
week. See also %U and %W.

=item * %w

The day of the I<décade> as a decimal, range 0 to 9, Décadi being 0.  See
also %u.

=item * %W

The I<décade> number of the current year as a decimal number, range 00
to 31.

=item * %y

The year as a decimal number without a century (range 00 to 99).

=item * %Y

The year as a decimal number including the century.

=item * %Ey

The year as a lowercase Roman number.

=item * %EY

The year as a uppercase Roman number, which is the traditional way
to write years when using the French Revolutionary calendar.

=item * %z

The time-zone as hour offset from UTC.  Required to emit
RFC822-conformant dates (using "%a, %d %b %Y %H:%M:%S %z").
Since the module does not support time zones, this gives
silly results and you cannot be RFC822-conformant.
Anyway, RFC822 requires the Gregorian calendar, doesn't it?

=item * %Z

The time zone or name or abbreviation, should the module have supported them.

=item * %%

A literal `%' character.

=back

=head1 REMARKS

=head2 Time Zones

Only the I<floating> time zone is supported.  Time zones were created
in the late XIXth century, at a time when instant communication
(electric telegraph) made it necessary.  But at this time, the French
Revolutionary calendar was no longer in use.

=head2 Leap Seconds

They are not supported.

=head2 I18N

For the moment, only French and English are available. For the English
translation, I have  used Thomas Carlyle's book and  Alan Taylor's web
site at kokogiak.com (see below).

Some feast names are not translated, other's translations are doubtful
(they are flagged with a question mark).  Remarks are welcome.

=head1 SUPPORT

Support for this module is provided via the datetime@perl.org email
list. See L<http://lists.perl.org/> for more details.

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

based on Dave Rolsky's DateTime module,  Eugene van der Pijll's 
DateTime::Calendar::Pataphysical module and my prior Date::Convert::French_Rev module.

The development of this module is hosted by I<Les Mongueurs de Perl>,
L<http://www.mongueurs.net/>.

=head1 SEE ALSO

=head2 Software

date(1), perl(1), DateTime(3), DateTime::Calendar::Pataphysical(3), Date::Convert::French_Rev

calendar/cal-french.el in emacs-21.2 or xemacs 21.1.8

=head2 Books

Quid 2001, M and D Frémy, publ. Robert Laffont

Agenda Républicain 197 (1988/89), publ. Syros Alternatives

Any French schoolbook about the French Revolution

The French Revolution, Thomas Carlyle, Oxford University Press

Calendrier Militaire, anonymous

=head2 Internet

http://datetime.perl.org/

http://www.faqs.org/faqs/calendars/faq/part3/

http://zapatopi.net/metrictime.html

http://www.kokogiak.com/frc/default.asp

=head1 LICENSE STUFF

Copyright (c) 2003 Jean Forget. All rights reserved. This program is
free software. You can distribute, modify, and otherwise mangle
DateTime::Calendar::FrenchRevolutionary under the same terms as perl.

=cut
