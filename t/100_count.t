use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#count' => sub {
    my $got;

    context 'single chain of count' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5 6/];
            my $enumerable = enumerable($source);

            $got = $enumerable->count;
        };

        it 'successful' => sub {
            is $got, 6;
        };
    };
};

runtests unless caller;