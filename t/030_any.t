use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#any' => sub {
    my $got;

    context 'when elements are not nothing' => sub {
        before all => sub {
            my $source     = [qw/2/];
            my $enumerable = enumerable($source);

            $got = $enumerable->any;
        };

        it 'returns true' => sub {
            ok $got;
        };
    };

    context 'when elements are nothing' => sub {
        before all => sub {
            my $source     = [qw//];
            my $enumerable = enumerable($source);

            $got = $enumerable->any;
        };

        it 'returns false' => sub {
            ok not $got;
        };
    };

    context 'when chained with other query function and it retuns one or more elements' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5/];
            my $enumerable = enumerable($source)->where(sub { $_ % 5 == 0 }); # you should use any_with, but this is test

            $got = $enumerable->any;
        };

        it 'returns true' => sub {
            ok $got;
        };
    };

    context 'when chained with other query function and it not return elements' => sub {
        before all => sub {
            my $source     = [qw/1 2 3 4 5/];
            my $enumerable = enumerable($source)->where(sub { $_ % 10 == 0 }); # you should use any_with, but this is test

            $got = $enumerable->any;
        };

        it 'returns false' => sub {
            ok not $got;
        };
    };
};

runtests unless caller;