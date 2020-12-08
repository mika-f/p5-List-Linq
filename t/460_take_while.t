use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#take_while' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'take items that lower than zero' => sub {
        before all => sub {
            $expected = [qw//];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->take_while(sub { $_ < 0 });

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
            $expected = [qw/1 2 3 4/];

            my $source     = [qw/1 2 3 4 5 6 7 8 9 10/];
            my $enumerable = enumerable($source)->take_while(sub { $_ < 5 });

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