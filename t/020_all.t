use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#all' => sub {
    my $got;

    context 'when all elements are matches to predicate function' => sub {
        before all => sub {
            my $source     = [qw/2 4 6 8 10/];
            my $enumerable = enumerable($source);

            $got = $enumerable->all(sub { $_ % 2 == 0 });
        };

        it 'returns true' => sub {
            ok $got;
        };
    };

    context 'when some elements are not matches to predicate function' => sub {
        before all => sub {
            my $source     = [qw/2 4 6 8 9/];
            my $enumerable = enumerable($source);

            $got = $enumerable->all(sub { $_ % 2 == 0 });
        };

        it 'returns false' => sub {
            ok not $got;
        };
    };

    context 'when chained with other query function and matches to predicate function' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5/];
            my $enumerable = enumerable($source)->select(sub { $_ * 2 });

            $got = $enumerable->all(sub { $_ % 2 == 0 });
        };

        it 'returns true' => sub {
            ok $got;
        };
    };
};

runtests unless caller;