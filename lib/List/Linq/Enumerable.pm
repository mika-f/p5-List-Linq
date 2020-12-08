package List::Linq::Enumerable;
use strict;
use warnings;

use Data::Compare;
use Scalar::Util qw/looks_like_number/;

use parent qw/List::Linq::Iterator/;

sub new {
    my $self = shift;
    my $list = @_;

    my $attr = +{
        array => defined $list ? (ref $list eq 'HASH' ? [@_] : @_) : [],
        index => -1,
        item  => undef,
    };

    my $class = ref $self || $self;
    return bless $attr, $class;
}

# extension implementations
# ported from System.Linq.Enumerable in .NET 5

sub aggregate {}

# All<TSource>(IEnumerable<TSource>, Func<TSource, Boolean>) -> Boolean
sub all {
    my $self      = shift;
    my $predicate = shift;

    die 'Argument Null Error : predicate'    unless $predicate;
    die 'Argument Invalid Error : predicate' unless ref($predicate) eq 'CODE';

    while ($self->move_next) {
        local $_ = $self->current;
        unless ($predicate->()) {
            return 0;
        }
    }

    return 1;
}

# Any<TSource>(IEnumerable<TSource>) -> Boolean
sub any {
    my $self = shift;

    return $self->move_next;
}

# Any<TSource>(IEnumerable<TSource>, Func<TSource, Boolean>) -> Boolean
sub any_with {
    my $self      = shift;
    my $predicate = shift;

    die 'Argument Null Error : predicate'    unless $predicate;
    die 'Argument Invalid Error : predicate' unless ref($predicate) eq 'CODE';

    while ($self->move_next) {
        local $_ = $self->current;
        if ($predicate->()) {
            return 1;
        }
    }

    return 0;
}

sub append {}

sub as_enumerable {}

# Average<IEnumerable<Number>> -> Number
sub average {
    my $self  = shift;
    my $sum   = 0;
    my $count = 0;

    while ($self->move_next) {
        my $item = $self->current;
        if (looks_like_number($item)) {
            $sum   += $item;
            $count += 1;
        }
    }

    return $sum / $count;
}

# Average<TSource>(IEnumerable<Number>, Func<TSource, Number>) -> Number
sub average_by {
    my $self     = shift;
    my $selector = shift;

    die 'Argument Null Error : selector'    unless $selector;
    die 'Argument Invalid Error : selector' unless ref($selector) eq 'CODE';

    my $sum   = 0;
    my $count = 0;

    while ($self->move_next) {
        local $_ = $self->current;
        my $item = $selector->();

        if (looks_like_number($item)) {
            $sum   += $item;
            $count += 1;
        }
    }

    return $sum / $count;
}

sub cast {
    die 'not implemented because Perl does not have static type system.';
}

sub concat {}

# Contains<TSource>(IEnumerable<TSource>, TSource) -> bool
sub contains {
    my $self  = shift;
    my $value = shift;

    while ($self->move_next) {
        if (Compare($self->current, $value)) {
            return 1;
        }
    }

    return 0;
}

# Count<TSource>(IEnumerable<TSource>) -> Number
sub count {
    my $self  = shift;
    my $count = 0;

    while ($self->move_next) {
        $count++;
    }

    return $count;
}

# Count<TSource>(IEnumerable<TSource>, Func<TSource, Boolean>) -> Number
sub count_with {
    my $self      = shift;
    my $predicate = shift;

    die 'Argument Null Error : predicate'    unless $predicate;
    die 'Argument Invalid Error : predicate' unless ref($predicate) eq 'CODE';

    my $count     = 0;

    while ($self->move_next) {
        local $_ = $self->current;
        if ($predicate->()) {
            $count++;
        }
    }

    return $count;
}

sub default_if_empty {
    die 'not implemented because Perl does not have static type system.';
}

sub distinct {}

sub element_at {}

sub element_at_or_default {
    die 'not implemented because Perl does not have static type system.';
}

sub empty {}

sub except {}

# First<TSource>(IEnumerable<TSource>) -> TSource
sub first {
    my $self = shift;

    if ($self->move_next) {
        return $self->current;
    }
}

# First<TSource>(IEnumerable<TSource>, Func<TSource, Boolean>) -> TSource
sub first_with {
    my $self      = shift;
    my $predicate = shift;

    die 'Argument Null Error : predicate'    unless $predicate;
    die 'Argument Invalid Error : predicate' unless ref($predicate) eq 'CODE';

    while ($self->move_next) {
        local $_ = $self->current;
        if ($predicate->()) {
            return $self->current;
        }
    }
}

sub first_or_default {
    die 'not implemented because Perl does not have static type system.';
}

sub group_by {}

sub group_join {}

sub intersect {}

sub last {}

sub last_or_default {
    die 'not implemented because Perl does not have static type system.';
}

sub long_count {
    my $self = shift;

    return $self->count;
}

sub max {}

sub min {}

sub of_type {
    die 'not implemented because Perl does not have static type system.';
}

sub order_by {}

sub order_by_descending {}

sub prepend {}

sub range {}

sub repeat {}

sub reverse {}

# Select<TSource, TResult>(IEnumerable<TSource>, Func<TSource, TResult>) -> IEnumerable<TResult>

use List::Linq::Query::Select;

sub select {
    my $self     = shift;
    my $selector = shift;

    die 'Argument Null Error : selector'    unless $selector;
    die 'Argument Invalid Error : selector' unless ref($selector) eq 'CODE';

    return List::Linq::Query::Select->new($self, $selector);
}

# Select<TSource, TResult>(IEnumerable<TSource>, Func<TSource, Int32, TResult>) -> IEnumerable<TResult>

use List::Linq::Query::SelectIndexed;

sub select_with_index {
    my $self     = shift;
    my $selector = shift;

    die 'Argument Null Error : selector'    unless $selector;
    die 'Argument Invalid Error : selector' unless ref($selector) eq 'CODE';

    return List::Linq::Query::SelectIndexed->new($self, $selector);
}

sub select_many {}

sub sequence_equal {}

sub single {}

sub single_or_default {
    die 'not implemented because Perl does not have static type system.';
}

sub skip {}

sub skip_last {}

sub skip_while {}

sub sum {}

# Take<TSource>(IEnumerable<TSource>, Int) -> IEnumerable<TSource>

use List::Linq::Query::Take;

sub take {
    my $self  = shift;
    my $count = shift;

    return List::Linq::Query::Take->new($self, $count);
}

sub take_last {}

sub take_while {}

sub then_by {}

sub then_by_descending {}

# ToArray<TSource>(IEnumerable<TSource>) -> TSource[]
sub to_array {
    my $self  = shift;
    my $array;

    while ($self->move_next) {
        push @{$array}, $self->current;
    }

    return wantarray ? @$array : $array;
}

sub to_dictionary {}

sub to_hash_set {}

sub to_list {}

sub to_lookup {}

sub union {}

# Where<TSource>(IEnumerable<TSource>, Func<TSource, Boolean>) -> IEnumerable<TSource>

use List::Linq::Query::Where;

sub where {
    my $self      = shift;
    my $predicate = shift;

    die 'Argument Null Error : predicate'    unless $predicate;
    die 'Argument Invalid Error : predicate' unless ref($predicate) eq 'CODE';

    return List::Linq::Query::Where->new($self, $predicate);
}

# Where<TSource>(IEnumerable<TSource>, Func<TSource, Int32, Boolean>) -> IEnumerable<TSource>

use List::Linq::Query::WhereIndexed;

sub where_with_index {
    my $self      = shift;
    my $predicate = shift;

    die 'Argument Null Error : predicate'    unless $predicate;
    die 'Argument Invalid Error : predicate' unless ref($predicate) eq 'CODE';

    return List::Linq::Query::WhereIndexed->new($self, $predicate);
}

# interface implementations

sub current {
    my $self  = shift;

    return $self->{item};
}

sub move_next {
    my $self  = shift;
    my $array = $self->{array};
    my $index = $self->{index};

    if ($index + 1 >= scalar(@$array)) {
        return 0;
    }

    $self->{index} = $index + 1;
    $self->{item}  = @{$self->{array}}[$self->{index}];

    return 1;
};



1;