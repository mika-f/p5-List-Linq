use strict;
use warnings;

use Test::Spec;
use Test::Deep;
use Test::Exception;

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
        my $enumerable;

        context 'greater than or equal to the number of elements' => sub {
            before all => sub {
                my $source     = [qw/1 2 3 4 5 6/];
                $enumerable = enumerable($source);
            };

            it 'throw exception' => sub {
                throws_ok {
                    $enumerable->element_at(10);
                } qr/ArgumentOutOfRangeException/;
            };
        };

        context 'less than 0' => sub {
            before all => sub {
                my $source     = [qw/1 2 3 4 5 6/];
                $enumerable = enumerable($source);
            };

            it 'throw exception' => sub {
                throws_ok {
                    $enumerable->element_at(-1);
                } qr/ArgumentOutOfRangeException/;
            };
        };
    };
};

runtests unless caller;