use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#skip_while_with_index' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'skip less than 0' => sub {
        before all => sub {
            $expected = [qw/a b c d e f/];

            my $source     = [qw/a b c d e f/];
            my $enumerable = enumerable($source)->skip_while_with_index(sub { $_[1] < 0 });

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };

    context 'skip less than 4 (index)' => sub {
        before all => sub {
            $expected = [qw/e f/];

            my $source     = [qw/a b c d e f/];
            my $enumerable = enumerable($source)->skip_while_with_index(sub { $_[1] < 4 });

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };
};

runtests unless caller;