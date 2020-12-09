use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#sequence_equal' => sub {
    my ($enumerable1, $enumerable2);

    context 'two sequence are equal' => sub {
        before all => sub {
            $enumerable1 = List::Linq->range(1, 10);
            $enumerable2 = enumerable([qw/1 2 3 4 5 6 7 8 9 10/]);
        };

        it 'returns true' => sub {
            ok $enumerable1->sequence_equal($enumerable2);
        };
    };

    context 'two sequence are not equal' => sub {
        before all => sub {
            $enumerable1 = List::Linq->range(1, 10)->take(5);
            $enumerable2 = enumerable([qw/1 2 3 4 5 6 7 8 9 10/]);
        };

        it 'returns false' => sub {
            ok not $enumerable1->sequence_equal($enumerable2);
        };
    };
};

runtests unless caller;