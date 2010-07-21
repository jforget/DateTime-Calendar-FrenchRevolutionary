use DateTime::Calendar::FrenchRevolutionary::Locale::en;
use DateTime::Calendar::FrenchRevolutionary::Locale::fr;

my $n = 0;

sub check {
  my ($method, $fr_result, $en_result) = @_;

  my $fr_test = DateTime::Calendar::FrenchRevolutionary::Locale::fr->$method;
  my $en_test = DateTime::Calendar::FrenchRevolutionary::Locale::en->$method;

  ++ $n;
  if ($fr_test eq $fr_result) {
    print "ok $n\n";
  }
  else {
    print "not ok $n : expected '$fr_result', got '$fr_test'\n";
  }

  ++ $n;
  if ($en_test eq $en_result) {
    print "ok $n\n";
  }
  else {
    print "not ok $n : expected '$en_result', got '$en_test'\n";
  }

}


my @tests = (
       [ "full_date_format",         "%A %d %B %EY, %{feast_long}",                 "%A %d %B %EY, %{feast_long}" ],
       [ "long_date_format",         "%A %d %B %EY",                                "%A %d %B %EY"                ],
       [ "medium_date_format",       "%a %d %b %Y",                                 "%a %d %b %Y"                 ],
       [ "short_date_format",        "%d/%m/%Y",                                    "%d/%m/%Y"                    ],
       [ "default_date_format",      "%a %d %b %Y",                                 "%a %d %b %Y"                 ],
       [ "full_time_format",         "%H h %M mn %S s",                             "%H h %M mn %S s"             ],
       [ "long_time_format",         "%H:%M:%S",                                    "%H:%M:%S",                   ],
       [ "medium_time_format",       "%H:%M:%S",                                    "%H:%M:%S",                   ],
       [ "short_time_format",        "%H:%M",                                       "%H:%M",                      ],
       [ "default_time_format",      "%H:%M:%S",                                    "%H:%M:%S",                   ],
       [ "full_datetime_format",     "%A %d %B %EY, %{feast_long} %H h %M mn %S s", "%A %d %B %EY, %{feast_long} %H h %M mn %S s" ],
       [ "long_datetime_format",     "%A %d %B %EY %H:%M:%S",                       "%A %d %B %EY %H:%M:%S"       ],
       [ "medium_datetime_format",   "%a %d %b %Y %H:%M:%S",                        "%a %d %b %Y %H:%M:%S"        ],
       [ "short_datetime_format",    "%d/%m/%Y %H:%M",                              "%d/%m/%Y %H:%M"              ],
       [ "default_datetime_format",  "%a %d %b %Y %H:%M:%S",                        "%a %d %b %Y %H:%M:%S"        ],
       [ "date_parts_order",         "dmy",                                         "dmy",                        ],
);

printf "1..%d\n", 2 * @tests;

foreach (@tests) { check @$_ }

