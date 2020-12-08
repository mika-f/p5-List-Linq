package List::Linq::Query::Take;
use strict;
use warnings;

use parent qw/List::Linq::Query/;

sub new {
    my $self       = shift;
    my $enumerable = shift;
    my $count      = shift;

    my $class = $self->SUPER::new($enumerable);
    $class->{count} = $count;

    return $class;
}

sub move_next {
    my $self  = shift;
    my $count = $self->{count};

    while (($self->{index} + 1) < $count && $self->SUPER::move_next) {
        $self->{item}  = $self->current;
        $self->{index} += 1;

        return 1;
    }

    return 0;
}

1;