use strict;
use warnings;

use Test::Spec;
use Test::Deep;
use Test::Exception;

use List::Linq;

describe 'Enumerable#repeat' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'range starts 0 with 0 elements' => sub {
        before all => sub {
            $expected = [qw//];

            my $enumerable = List::Linq->repeat('Hello, World', 0);

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
            $expected = [split(/_/, 'Hello, World_' x 10)];

            my $enumerable = List::Linq->repeat('Hello, World', 10);

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
            $expected = [split(/_/, 'Hello, World_' x 10)];

            my $enumerable = List::Linq->repeat("Hello, World", "inf")->take(10);

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
                List::Linq->repeat('Hello World', -1);
            } qr/ArgumentOutOfRangeException/;
        };
    };
};

runtests unless caller;