use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#take_last' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'take last 0 items' => sub {
        before all => sub {
            $expected = [qw//];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->take_last(0);

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, undef;
        };
    };

    context 'take last 3 items' => sub {
        before all => sub {
            $expected = [qw/8 9 10/];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->take_last(3);

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