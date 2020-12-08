use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#empty' => sub {
    my $got;

    context 'element_at in range' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5 6/];
            my $enumerable = List::Linq->empty;

            $got = $enumerable->count;
        };

        it 'successful' => sub {
            is $got, 0;
        };
    };
};

runtests unless caller;