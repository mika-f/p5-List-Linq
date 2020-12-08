requires 'perl', '5.030';

requires 'Data::Compare';
requires 'Exporter::Lite';

on 'test' => sub {
    requires 'Test::Deep';
    requires 'Test::More', '0.98';
    requires 'Test::Spec';
};

