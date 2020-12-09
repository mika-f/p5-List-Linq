use strict;
use warnings;

use Test::Spec;
use Test::Deep;
use Test::Exception;

use List::Linq;

describe 'Enumerable#first' => sub {
    my $got;

    context 'single chain of first' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source);

           $got = $enumerable->first;
        };

        it 'successful' => sub {
            cmp_deeply $got, 1;
        };
    };

    context 'when source is empty' => sub {
        my $enumerable;

        before all => sub {
            $enumerable = enumerable([]);
        };

        it 'throw exception' => sub {
            throws_ok {
                $enumerable->first;
            } qr/InvalidOperationException/;
        };
    };
};

runtests unless caller;