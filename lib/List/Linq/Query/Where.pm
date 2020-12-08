package List::Linq::Query::Where;
use strict;
use warnings;

use parent qw/List::Linq::Query/;

sub new {
    my $self       = shift;
    my $enumerable = shift;
    my $predicate  = shift;

    my $class = $self->SUPER::new($enumerable);
    $class->{predicate} = $predicate;

    return $class;
}

sub move_next {
    my $self      = shift;
    my $predicate = $self->{predicate};

    while ($self->SUPER::move_next) {
        my $item = $self->current;

        local $_ = $item;
        if ($predicate->()) {
            $self->{item} = $item;

            return 1;
        }
    }

    return 0;
}

1;