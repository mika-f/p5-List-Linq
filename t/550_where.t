use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#where' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'single chain of where' => sub {
        before all => sub {
            $expected = [qw/2 4 6 8 10/];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->where(sub { $_ % 2 == 0 });

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };

    context 'twice chain of where' => sub {
        before all => sub {
            $expected = [qw/6/];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->where(sub { $_ % 2 == 0 })
                                                ->where(sub { $_ % 3 == 0 });

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