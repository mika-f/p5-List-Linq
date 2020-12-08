use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#select_with_index' => sub {
    my ($got, $expected);

    before each => sub {
        $got = ();
    };

    context 'single chain of select' => sub {
        before all => sub {
            $expected = [qw/a bb ccc dddd eeeee ffffff/];

            my $source     = [qw/a b c d e f/];
            my $enumerable = enumerable($source)->select_with_index(sub { $_[0] x ($_[1] + 1) });

            while ($enumerable->move_next) {
                push @{$got}, $enumerable->current;
            }
        };

        it 'successful' => sub {
            cmp_deeply $got, $expected;
        };
    };

    context 'twice chain of select' => sub {
        before all => sub {
            $expected = [qw/1.a 2.bb 3.ccc 4.dddd 5.eeeee 6.ffffff/];

            my $source     = [qw/a b c d e f/];
            my $enumerable = enumerable($source)->select_with_index(sub { $_[0] x ($_[1] + 1 ) })
                                                ->select_with_index(sub { ($_[1] + 1) . '.' . $_[0] });

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