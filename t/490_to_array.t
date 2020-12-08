use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#to_array' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'single chain of to_array' => sub {
        before all => sub {
            $expected = [qw/1 2 3 4 5/];

            my $source     = [qw/1 2 3 4 5/];
            my $enumerable = enumerable($source);

            $got = $enumerable->to_array;
        };

        it 'returns array of elements' => sub {
            cmp_deeply $got, $expected;
        };
    };

    context 'chain of to_array' => sub {
        before all => sub {
            $expected = [qw/1 3 5/];

            my $source     = [qw/1 2 3 4 5/];
            my $enumerable = enumerable($source)->where(sub { $_ % 2 == 1 });

            $got = $enumerable->to_array;
        };

        it 'returns filtered array of elements' => sub {
            cmp_deeply $got, $expected;
        };
    };
};

runtests unless caller;