use strict;
use warnings;

use Test::Spec;
use Test::Deep;
use Test::Exception;

use List::Linq;

describe 'Enumerable#range' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'range starts 0 with 0 elements' => sub {
        before all => sub {
            $expected = [qw//];

            my $enumerable = List::Linq->range(0, 0);

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, undef;
        };
    };

    context 'range starts 0 with 10 elements' => sub {
        before all => sub {
            $expected = [qw/0 1 2 3 4 5 6 7 8 9/];

            my $enumerable = List::Linq->range(0, 10);

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };

    context 'range starts 0 with infinity elements but take 10 items' => sub {
        before all => sub {
            $expected = [qw/0 1 2 3 4 5 6 7 8 9/];

            my $enumerable = List::Linq->range(0, "inf")->take(10);

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };

    context 'pass count to -1' => sub {
        it 'throw exception' => sub {
            throws_ok {
                List::Linq->range(0, -1);
            } qr/ArgumentOutOfRangeException/;
        };
    };
};

runtests unless caller;