package List::Linq::Query::TakeWhile;
use strict;
use warnings;

use parent qw/List::Linq::Query/;

sub new {
    my $self       = shift;
    my $enumerable = shift;
    my $predicate  = shift;

    my $class = $self->SUPER::new($enumerable);
    $class->{predicate}   = $predicate;
    $class->{is_finished} = 0;

    return $class;
}

sub move_next {
    my $self      = shift;
    my $predicate = $self->{predicate};

    unless ($self->{is_finished}) {
        $self->SUPER::move_next;

        local $_ = $self->current;
        if ($predicate->()) {
            return 1;
        }

        $self->{is_finished} = 1;
    }

    return 0;
}

1;