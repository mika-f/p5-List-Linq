use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#count_with' => sub {
    my $got;

    context 'single chain of count' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5 6/];
            my $enumerable = enumerable($source);

            $got = $enumerable->count_with(sub { $_ % 2 == 0 });
        };

        it 'successful' => sub {
            is $got, 3;
        };
    };
};

runtests unless caller;