use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#first_with' => sub {
    my $got;

    context 'single chain of first_with' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source);

           $got = $enumerable->first_with(sub { $_ % 5 == 0 });
        };

        it 'successful' => sub {
            cmp_deeply $got, 5;
        };
    };
};

runtests unless caller;