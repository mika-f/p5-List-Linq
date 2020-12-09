package List::Linq::Enumerable;
use strict;
use warnings;

use Carp qw/croak/;
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

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

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

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

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

# Average(IEnumerable<Number>) -> Number
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

    if ($count == 0) {
        croak 'InvalidOperationException : source contains no elements';
    }

    return $sum / $count;
}

# Average<TSource>(IEnumerable<Number>, Func<TSource, Number>) -> Number
sub average_by {
    my $self     = shift;
    my $selector = shift;

    croak 'ArgumentNullException : selector is null'       unless $selector;
    croak 'InvalidTypeException : selector is not coderef' unless ref($selector) eq 'CODE';

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

    if ($count == 0) {
        croak 'InvalidOperationException : source contains no elements';
    }

    return $sum / $count;
}

sub cast {
    croak 'NotImplementedException: Perl does not support static type system.';
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

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

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
    croak 'NotImplementedException: Perl does not support static type system.';
}

sub distinct {}

# ElementAt<TSource>(IEnumerable<TSource>, Number) -> TSource
sub element_at {
    my $self  = shift;
    my $index = shift;

    my $count = 0;
    while ($self->move_next) {
        if ($count++ == $index) {
            return $self->current;
        }
    }

    croak 'ArgumentOutOfRangeException: index is less than 0 or greater than or equal to the number of elements in source';
}

sub element_at_or_default {
    croak 'NotImplementedException: Perl does not support static type system.';
}

sub except {}

# First<TSource>(IEnumerable<TSource>) -> TSource
sub first {
    my $self = shift;

    if ($self->move_next) {
        return $self->current;
    }

    croak 'InvalidOperationException: source sequence is empty';
}

# First<TSource>(IEnumerable<TSource>, Func<TSource, Boolean>) -> TSource
sub first_with {
    my $self      = shift;
    my $predicate = shift;

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

    while ($self->move_next) {
        local $_ = $self->current;
        if ($predicate->()) {
            return $self->current;
        }
    }

    croak 'InvalidOperationException: source sequence is empty or no element satisfies the condition in predicate';
}

sub first_or_default {
    croak 'NotImplementedException: Perl does not support static type system.';
}

sub group_by {}

sub group_join {}

sub intersect {}

# Last<TSource>()
sub last {}

sub last_or_default {
    croak 'NotImplementedException: Perl does not support static type system.';
}

sub long_count {
    my $self = shift;

    return $self->count;
}

sub max {}

sub min {}

sub of_type {
    croak 'NotImplementedException: Perl does not support static type system.';
}

sub order_by {}

sub order_by_descending {}

sub prepend {}

sub repeat {}

sub reverse {}

# Select<TSource, TResult>(IEnumerable<TSource>, Func<TSource, TResult>) -> IEnumerable<TResult>

use List::Linq::Query::Select;

sub select {
    my $self     = shift;
    my $selector = shift;

    croak 'ArgumentNullException : selector is null'       unless $selector;
    croak 'InvalidTypeException : selector is not coderef' unless ref($selector) eq 'CODE';

    return List::Linq::Query::Select->new($self, $selector);
}

# Select<TSource, TResult>(IEnumerable<TSource>, Func<TSource, Number, TResult>) -> IEnumerable<TResult>

use List::Linq::Query::SelectIndexed;

sub select_with_index {
    my $self     = shift;
    my $selector = shift;

    croak 'ArgumentNullException : selector is null'       unless $selector;
    croak 'InvalidTypeException : selector is not coderef' unless ref($selector) eq 'CODE';

    return List::Linq::Query::SelectIndexed->new($self, $selector);
}

sub select_many {}

sub sequence_equal {}

sub single {}

sub single_or_default {
    croak 'NotImplementedException: Perl does not support static type system.';
}

# Skip<TSource>(IEnumerable<TSource>, Number) -> IEnumerable<TSource>

use List::Linq::Query::Skip;

sub skip {
    my $self  = shift;
    my $count = shift;

    return List::Linq::Query::Skip->new($self, $count);
}

sub skip_last {}

# SkipWhile<TSource>(IEnumerable<TSource>, Func<TSource, Boolean>) -> IEnumerable<TSource>

use List::Linq::Query::SkipWhile;

sub skip_while {
    my $self      = shift;
    my $predicate = shift;

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

    return List::Linq::Query::SkipWhile->new($self, $predicate);
}

# SkipWhile<TSource>(IEnumerable<TSource>, Func<TSource, Number, Boolean>) -> IEnumerable<TSource>

use List::Linq::Query::SkipWhileIndexed;

sub skip_while_with_index {
    my $self      = shift;
    my $predicate = shift;

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

    return List::Linq::Query::SkipWhileIndexed->new($self, $predicate);
}

# Sum(IEnumerable<Number>) -> NUmber
sub sum {
    my $self   = shift;
    my $sum    = 0;

    while ($self->move_next) {
        my $item = $self->current;
        if (looks_like_number($item)) {
            $sum += $item;
        }
    }

    return $sum;
}

# Sum<TSource>(IEnumerale<TSource>, Func<TSource, Number>) -> Number
sub sum_by {
    my $self     = shift;
    my $selector = shift;

    croak 'ArgumentNullException : selector is null'       unless $selector;
    croak 'InvalidTypeException : selector is not coderef' unless ref($selector) eq 'CODE';

    my $sum    = 0;

    while ($self->move_next) {
        local $_ = $self->current;
        my $item = $selector->();

        if (looks_like_number($item)) {
            $sum += $item;
        }
    }

    return $sum;
}

# Take<TSource>(IEnumerable<TSource>, Number) -> IEnumerable<TSource>

use List::Linq::Query::Take;

sub take {
    my $self  = shift;
    my $count = shift;

    return List::Linq::Query::Take->new($self, $count);
}

# TakeLast<TSource>(IEnumerable<TSource>, Number) -> IEnumerable<TSource>

use List::Linq::Query::TakeLast;

sub take_last {
    my $self  = shift;
    my $count = shift;

    return List::Linq::Query::TakeLast->new($self, $count);
}

# TakeWhile<TSource>(IEnumerable<TSource>, Func<TSource, Boolean>) -> IEnumerable<TSource>

use List::Linq::Query::TakeWhile;

sub take_while {
    my $self      = shift;
    my $predicate = shift;

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

    return List::Linq::Query::TakeWhile->new($self, $predicate);
}

# TakeWhile<TSource>(IEnumerable<TSource>, Func<TSource, Number, Boolean>) -> IEnumerable<TSource>

use List::Linq::Query::TakeWhileIndexed;

sub take_while_with_index {
    my $self      = shift;
    my $predicate = shift;

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

    return List::Linq::Query::TakeWhileIndexed->new($self, $predicate);
}

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

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

    return List::Linq::Query::Where->new($self, $predicate);
}

# Where<TSource>(IEnumerable<TSource>, Func<TSource, Number, Boolean>) -> IEnumerable<TSource>

use List::Linq::Query::WhereIndexed;

sub where_with_index {
    my $self      = shift;
    my $predicate = shift;

    croak 'ArgumentNullException : predicate is null'       unless $predicate;
    croak 'InvalidTypeException : predicate is not coderef' unless ref($predicate) eq 'CODE';

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