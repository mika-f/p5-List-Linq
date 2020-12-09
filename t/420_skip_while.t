use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#skip_while' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'skip less than 0' => sub {
        before all => sub {
            $expected = [qw/1 2 3 4 5 6 7 8 9 10/];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->skip_while(sub { $_ < 0 });

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };

    context 'skip less than 4' => sub {
        before all => sub {
            $expected = [qw/4 5 6 7 8 9 10/];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->skip_while(sub { $_ < 4 });

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };
};

runtests unless caller;