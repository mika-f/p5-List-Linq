use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#element_at' => sub {
    my $got;

    context 'element_at in range' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5 6/];
            my $enumerable = enumerable($source);

            $got = $enumerable->element_at(3);
        };

        it 'successful' => sub {
            is $got, 4;
        };
    };

    context 'element_at out of range' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5 6/];
            my $enumerable = enumerable($source);

            $got = $enumerable->element_at(10);
        };

        it 'successful' => sub {
            is $got, undef;
        };
    };
};

runtests unless caller;