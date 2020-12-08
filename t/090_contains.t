use strict;
use warnings;

use Test::Spec;
use Test::Deep;

use List::Linq;

describe 'Enumerable#contains' => sub {
    my $got;

    context 'compare with scalar' => sub {
        context 'two elements are matched' => sub {
            before all => sub {
                my $source     = [qw/1 2 hello world 3/];
                my $enumerable = enumerable($source);

                $got = $enumerable->contains('hello');
            };

            it 'returns true' => sub {
                ok $got;
            };
        };
        
        context 'two elements are not matched' => sub {
            before all => sub {
                my $source     = [qw/1 2 hello world 3/];
                my $enumerable = enumerable($source);

                $got = $enumerable->contains('Hello');
            };

            it 'returns false' => sub {
                ok not $got;
            };
        };
    };

    context 'compare with object' => sub {
        context 'two elements are matched' => sub {
            before all => sub {
                my $source     = [
                    +{ name => 'Apple',     ticker => 'APPL' },
                    +{ name => 'Alphabet',  ticker => 'GOOG' },
                    +{ name => 'Microsoft', ticker => 'MSFT' },
                ];
                my $enumerable = enumerable($source);

                $got = $enumerable->contains(+{ name => 'Apple', ticker => 'APPL' });
            };

            it 'returns true' => sub {
                ok $got;
            };
        };
        
        context 'two elements are not matched' => sub {
            before all => sub {
                my $source     = [
                    +{ name => 'Apple',     ticker => 'APPL' },
                    +{ name => 'Alphabet',  ticker => 'GOOG' },
                    +{ name => 'Microsoft', ticker => 'MSFT' },
                ];
                my $enumerable = enumerable($source);

                $got = $enumerable->contains(+{ name => 'Microsoft', ticker => 'MSHQ' });
            };

            it 'returns false' => sub {
                ok not $got;
            };
        };
    };
};

runtests unless caller;