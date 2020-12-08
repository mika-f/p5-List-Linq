use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#any_with' => sub {
    my $got;

    context 'when chained with other query function and it retuns one or more elements' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5/];
            my $enumerable = enumerable($source);

            $got = $enumerable->any_with(sub { $_ % 5 == 0 });
        };

        it 'returns true' => sub {
            ok $got;
        };
    };

    context 'when chained with other query function and it not return elements' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5/];
            my $enumerable = enumerable($source);

            $got = $enumerable->any_with(sub { $_ % 10 == 0 });
        };

        it 'returns false' => sub {
            ok not $got;
        };
    };
};

runtests unless caller;