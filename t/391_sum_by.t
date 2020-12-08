use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#sum' => sub {
    my $got;

    context 'all elements are numeric' => sub {
        before all => sub {
            my $source     = [
                +{ name => 'Sophie Neuenmuller', age => 16 },
                +{ name => 'Corneria',           age => 15 },
            ];
            my $enumerable = enumerable($source);

            $got = $enumerable->sum_by(sub { $_->{age} });
        };

        it 'retuens sum of all elements' => sub {
            is $got, 31;
        };
    };

    context 'some elements are not numeric' => sub {
        before all => sub {
            my $source     = [
                +{ name => 'Int', value => 1 },
                +{ name => 'Str', value => 'Hello' },
                +{ name => 'Int', value => 3 },
            ];
            my $enumerable = enumerable($source);

            $got = $enumerable->sum_by(sub { $_->{value} });
        };

        it 'returns sum of numeric elements' => sub {
            is $got, 4;
        };
    };
};

runtests unless caller;