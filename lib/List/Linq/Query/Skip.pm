package List::Linq::Query::Skip;
use strict;
use warnings;

use parent qw/List::Linq::Query/;

sub new {
    my $self       = shift;
    my $enumerable = shift;
    my $count      = shift;

    my $class = $self->SUPER::new($enumerable);
    $class->{count} = $count;
    $class->{index} = 0;

    return $class;
}

sub move_next {
    my $self  = shift;
    my $count = $self->{count};

    while (($self->{index}) < $count && $self->SUPER::move_next) {
        $self->{index} += 1;
    }

    return $self->SUPER::move_next;
}

1;