package List::Linq::Query::TakeLast;
use strict;
use warnings;

use parent qw/List::Linq::Query/;

sub new {
    my $self       = shift;
    my $enumerable = shift;
    my $count      = shift;

    my $class = $self->SUPER::new($enumerable);
    $class->{count} = $count;
    $class->{queue} = undef;

    return $class;
}

sub current {
    my $self = shift;

    return $self->{item};
}

sub move_next {
    my $self  = shift;
    my $count = $self->{count};

    if ($count == 0) {
        return 0;
    }

    unless (defined($self->{queue})) {
        my $items = 0;

        while ($self->SUPER::move_next) {
            if ($items < $count) {
                push @{$self->{queue}}, $self->SUPER::current;
                $items++;
            } else {
                do {
                    shift @{$self->{queue}};
                    push  @{$self->{queue}}, $self->SUPER::current;
                } while ($self->SUPER::move_next);
            }
        }
    }

    $self->{item} = shift @{$self->{queue}};
    return defined($self->{item});
}

1;