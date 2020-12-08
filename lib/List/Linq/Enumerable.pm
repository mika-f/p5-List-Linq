package List::Linq::Enumerable;
use strict;
use warnings;

use Scalar::Util qw/looks_like_number/;

use parent qw/List::Linq::Iterator/;

sub new {
    my $self = shift;
    my $list = @_;

    my $attr = +{
        array => defined $list ? (ref $list eq 'HASH' ? [@_] : @_) : [],
        index => -1,
        item  => undef,
    };

    my $class = ref $self || $self;
    return bless $attr, $class;
}

# extension implementations
# ported from System.Linq.Enumerable in .NET 5

# All<TSource>(IEnumerable<TSource>, Func<TSource, Boolean>) -> Boolean
sub all {
    my $self      = shift;
    my $predicate = shift;

    die 'Argument Null Error : predicate'    unless $predicate;
    die 'Aegument Invalid Error : predicate' unless ref($predicate) eq 'CODE';

    while ($self->move_next) {
        local $_ = $self->current;
        unless ($predicate->()) {
            return 0;
        }
    }

    return 1;
}


# interface implementations

sub current {
    my $self  = shift;

    return $self->{item};
}

sub move_next {
    my $self  = shift;
    my $array = $self->{array};
    my $index = $self->{index};

    if ($index + 1 >= scalar(@$array)) {
        return 0;
    }

    $self->{index} = $index + 1;
    $self->{item}  = @{$self->{array}}[$self->{index}];

    return 1;
};



1;