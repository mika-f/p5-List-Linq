use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#select' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'single chain of select' => sub {
        before all => sub {
            $expected = [qw/1 4 9 16 25 36/];

            my $source     = [qw/1 2 3 4 5 6/];
            my $enumerable = enumerable($source)->select(sub { $_ * $_ });

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };

    context 'twice chain of select' => sub {
        before all => sub {
            $expected = [qw/1 2 3 4 5 6/];

            my $source     = [qw/1 2 3 4 5 6/];
            my $enumerable = enumerable($source)->select(sub { $_ * $_ })
                                                ->select(sub { sqrt($_) });

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