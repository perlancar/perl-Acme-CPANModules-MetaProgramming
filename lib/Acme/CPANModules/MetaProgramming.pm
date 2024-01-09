package Acme::CPANModules::MetaProgramming;

use strict;
use warnings;

use Acme::CPANModulesUtil::Misc;

# AUTHORITY
# DATE
# DIST
# VERSION

my $text = <<'_';
**What is metaprogramming**

In this article's context, metaprogramming is a set of techniques to generate
other programs dynamically as well as to examine or modify the behavior of
programming elements (packages, classes, subroutines, methods, etc).

Keywords: reflection API, reflective programming, meta, MOP, meta object
protocol


**Checking if a method or subroutine exists**

No additional tool needed. Already pretty straightforward in Perl:

    say "Function foo is defined" if defined &foo;
    say "Function MyPackage::foo is defined" if defined &MyPackage::foo;

    say "Object has method foo" if $obj->can("foo");


**Creating a class programmatically**

With plain ol' eval:

    eval "package Foo; sub { ... } ...";

With <pm:Moose> classes which sport MOP, you can do:

    Class::MOP::Class->create(
        'Foo' => {
            version      => '0.01',
            superclasses => ['SuperFoo'],
            attributes   => [
                Class::MOP::Attribute->new('$bar'),
                Class::MOP::Attribute->new('$baz'),
            ],
            methods => {
                calculate_bar => sub {...},
                construct_baz => sub {...}
            }
        )
    );


**Creating a subroutine or method programmatically**

With plain ol' `eval()`:

    my $newsub = eval "sub { ... }";
    eval "package Foo; sub bar { ... }";

With <pm:Moose> classes which sport MOP, you can do:

    Some::Class->meta->add_method('foo' => sub { ... });


**Deleting a subroutine or a method**

Use <prog:Sub::Delete>.

With <pm:Moose> classes which sport MOP, you can do:

    Some::Class->meta->remove_method("foo");


**Invoking a subroutine or method whose name is in a variable**

No additional tool needed. Already pretty straightforward in Perl:

    no strict 'refs';
    &{"$subname"}->($arg, ...)

    $obj->$methodname($arg, ...)
    Some::Class->$methodname($arg, ...)

_

our $LIST = {
    summary => 'List of modules/tools to do metaprogramming',
    description => $text,
    tags => ['task'],
};

Acme::CPANModulesUtil::Misc::populate_entries_from_module_links_in_description;

1;
# ABSTRACT:
