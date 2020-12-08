use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#take_while_with_index' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'take items that lower than zero' => sub {
        before all => sub {
            $expected = [qw//];

            my $source     = [qw/a b c d e f g/];
            my $enumerable = enumerable($source)->take_while_with_index(sub { $_[1] < 0 });

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, undef;
        };
    };

    context 'take items that lower than 5' => sub {
        before all => sub {
            $expected = [qw/a b c d e/];

            my $source     = [qw/a b c d e f g/];
            my $enumerable = enumerable($source)->take_while_with_index(sub { $_[1] < 5 });

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