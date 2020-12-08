# NAME

List::Linq - .NET LINQ port to Perl.

# SYNOPSIS

```perl
    use List::Linq;

    my $data = [
        { user => { id => 1, name => 'Sophie Neuenmuller' }, series => [qw/A17 A18 A19/] },
        { user => { id => 2, name => 'Plachta' },            series => [qw/A17 A18 A19/] },
        { user => { id => 3, name => 'Corneria' },           series => [qw/A17 A19/] },
    ];

    # ['Sophie Neuenmuller', 'Corneria']
    my $filtered = enumerable(@$data)->where(sub { $_->{user}->{id} % 2 == 1 }) # filter by index
                                     ->select(sub { $_->{user}->{name} })       # get user name
                                     ->to_array();                              # get result as array
```

# DESCRIPTION

A powerful language integrated query (LINQ) library for Perl5.

# LICENSE

Copyright (C) Mikazuki Fuyuno.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Mikazuki Fuyuno &lt;mikazuki\_fuyuno@outlook.com>
