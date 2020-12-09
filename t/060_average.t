use strict;
use warnings;

use Test::Spec;
use Test::Deep;
use Test::Exception;

use List::Linq;

describe 'Enumerable#average' => sub {
    my $got;

    context 'all elements are numeric' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5 6/];
            my $enumerable = enumerable($source);

            $got = $enumerable->average();
        };

        it 'retuens average of all elements' => sub {
            is $got, 3.5;
        };
    };

    context 'some elements are not numeric' => sub {
        before all => sub {
            my $source     = [qw/1 a 2 b 3 c 4 d 5 e 6/];
            my $enumerable = enumerable($source);

            $got = $enumerable->average();
        };

        it 'returns average of numeric elements' => sub {
            is $got, 3.5;
        };
    };

    context 'when source is empty list, throw exception' => sub {
        my $enumerable;

        before all => sub {
            $enumerable = enumerable([]);
        };

        it 'throw exception' => sub {
            throws_ok {
                $enumerable->average;
            } qr/InvalidOperationException/;
        };
    };
};

runtests unless caller;