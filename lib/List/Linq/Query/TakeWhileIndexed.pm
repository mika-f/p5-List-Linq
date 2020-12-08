package List::Linq::Query::TakeWhileIndexed;
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

        if ($predicate->($self->current, ++$self->{index})) {
            return 1;
        }

        $self->{is_finished} = 1;
    }

    return 0;
}

1;