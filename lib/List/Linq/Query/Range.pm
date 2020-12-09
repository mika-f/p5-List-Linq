package List::Linq::Query::Range;
use strict;
use warnings;

use parent qw/List::Linq::Query/;

sub new {
    my $self       = shift;
    my $enumerable = shift;
    my $start      = shift;
    my $count      = shift;

    my $class = $self->SUPER::new($enumerable);
    $class->{start} = $start;
    $class->{count} = $count;

    return $class;
}

sub current {
    my $self = shift;

    return $self->{item};
}

sub move_next {
    my $self  = shift;
    my $start = $self->{start};
    my $count = $self->{count};

    unless (defined($self->current)) {
        $self->{item} = $start;
    } else {
        $self->{item} += 1;
    }

    return $self->{item} < ($start + $count);
}

1;