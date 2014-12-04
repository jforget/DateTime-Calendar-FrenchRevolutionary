#
#     Test script for DateTime::Calendar::FrenchRevolutionary
#     Copyright (C) 2010, 2011, 2012, 2014 Jean Forget
#
#     This program is distributed under the same terms as Perl 5.16.3:
#     GNU Public License version 1 or later and Perl Artistic License
#
#     You can find the text of the licenses in the F<LICENSE> file or at
#     L<http://www.perlfoundation.org/artistic_license_1_0>
#     and L<http://www.gnu.org/licenses/gpl-1.0.html>.
#
#     Here is the summary of GPL:
#
#     This program is free software; you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation; either version 1, or (at your option)
#     any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program; if not, write to the Free Software Foundation,
#     Inc., <http://www.fsf.org/>.
#
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

