use strict;
use Test::More 0.98 tests => 2;
use Test::More::UTF8;

use File::Share 'dist_dir';
my $dir = dist_dir('Data-Pokemon-Go');

use lib './lib';

use_ok('Data::Pokemon::Go::Pokemon');                                   # 1

unless( -e "$dir/MeCab.csv" ) {
    require Text::CSV_XS;
    my $csv = Text::CSV_XS->new ({ binary => 1, quote_char => undef });
    open my $fh, ">:encoding(utf8)", "$dir/MeCab.csv" or die "Couldn't open CSV: $!";
    $csv->say( $fh, $_ ) for map{
        [ $_, 1, 1, 1, '名詞', '固有名詞', '一般', '*', '*', '*', $_, $_, $_ ]
    } @Data::Pokemon::Go::Pokemon::All;
    close $fh or die "Couldn't write CSV: $!";
}
is -e "$dir/MeCab.csv", 1, "Succeed to create $dir/MeCab.csv";          # 2

done_testing();
