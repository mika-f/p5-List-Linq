package List::Linq::Query;
use strict;
use warnings;

use parent qw/List::Linq::Enumerable/;

sub new {
    my $self       = shift;
    my $enumerable = shift;

    my $class = $self->SUPER::new([]);
    $class->{enumerable} = $enumerable;

    return $class;
}

sub current {
    my $self = shift;

    return $self->{enumerable}->current;
}

sub move_next {
    my $self = shift;

    return $self->{enumerable}->move_next;
}

1;
