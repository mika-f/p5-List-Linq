package List::Linq::Query::SelectIndexed;
use strict;
use warnings;

use parent qw/List::Linq::Query/;

sub new {
    my $self       = shift;
    my $enumerable = shift;
    my $selector   = shift;

    my $class = $self->SUPER::new($enumerable);
    $class->{selector} = $selector;

    return $class;
}

sub current {
    my $self = shift;

    return $self->{item};
}

sub move_next {
    my $self     = shift;
    my $selector = $self->{selector};

    if ($self->SUPER::move_next) {
        $self->{item} = $selector->($self->SUPER::current, ++$self->{index});

        return 1;
    }

    return 0;
}

1;