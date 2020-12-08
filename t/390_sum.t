use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#sum' => sub {
    my $got;

    context 'all elements are numeric' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5 6/];
            my $enumerable = enumerable($source);

            $got = $enumerable->sum();
        };

        it 'retuens sum of all elements' => sub {
            is $got, 21;
        };
    };

    context 'some elements are not numeric' => sub {
        before all => sub {
            my $source     = [qw/1 a 2 b 3 c 4 d 5 e 6/];
            my $enumerable = enumerable($source);

            $got = $enumerable->sum();
        };

        it 'returns sum of numeric elements' => sub {
            is $got, 21;
        };
    };
};

runtests unless caller;