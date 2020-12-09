package List::Linq::Query::Repeat;
use strict;
use warnings;

use parent qw/List::Linq::Query/;

sub new {
    my $self       = shift;
    my $enumerable = shift;
    my $value      = shift;
    my $count      = shift;

    my $class = $self->SUPER::new($enumerable);
    $class->{value} = $value;
    $class->{count} = $count;
    $class->{index} = 0;

    return $class;
}

sub current {
    my $self = shift;

    return $self->{value};
}

sub move_next {
    my $self  = shift;
    my $count = $self->{count};

    return $self->{index}++ < $count;
}

1;