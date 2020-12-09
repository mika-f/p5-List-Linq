use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#skip' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'skip 0 items' => sub {
        before all => sub {
            $expected = [qw/1 2 3 4 5 6 7 8 9 10/];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->skip(0);

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };

    context 'skip 3 items' => sub {
        before all => sub {
            $expected = [qw/4 5 6 7 8 9 10/];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->skip(3);

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