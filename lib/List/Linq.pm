package List::Linq;
use 5.030;
use strict;
use warnings;

use Carp qw/croak/;
use Exporter::Lite;

use List::Linq::Enumerable;

our $VERSION = "0.01";
our @EXPORT  = qw/enumerable/;

sub enumerable {
    List::Linq::Enumerable->new(@_);
}

# static Empty<TSource>() -> IEnumerable<TSource>
sub empty {
    my $self = shift;

    return enumerable([]);
}

# static Range(Number, Number) -> IEnumerable<Number>
use List::Linq::Query::Range;

sub range {
    my $self  = shift;
    my $start = shift;
    my $count = shift;

    croak 'ArgumentOutOfRangeException: count is less than 0' if $count < 0;

    return List::Linq::Query::Range->new(enumerable([]), $start, $count);
}

# static Repeat<TResult>(TResult, Number) -> IEnumerable<TResult>
use List::Linq::Query::Repeat;

sub repeat {
    my $self  = shift;
    my $value = shift;
    my $count = shift;

    croak 'ArgumentOutOfRangeException: count is less than 0' if $count < 0;

    return List::Linq::Query::Repeat->new(enumerable([]), $value, $count);
}

1;
__END__

=encoding utf-8

=head1 NAME

List::Linq - It's new $module

=head1 SYNOPSIS

    use List::Linq;

=head1 DESCRIPTION

List::Linq is ...

=head1 LICENSE

Copyright (C) Mikazuki Fuyuno.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Mikazuki Fuyuno E<lt>mikazuki_fuyuno@outlook.comE<gt>

=cut

