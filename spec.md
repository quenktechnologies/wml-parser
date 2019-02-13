
Widget Markup Language Specification
====================================

# Introduction

The Widget Markup Language or WML is a syntax for describing
user interfaces in dynamic Web applications.

WML serves as an alternative to DOM APIs such as `document.createElement`
by providing an XML like syntax that can be compiled to ECMAScript.

The first interation of an WML compiler compiled to ECMAScript directly however,
the need for stronger typing became apparent in order to escape the dreaded
"x is not a function" class of errors.

As a result, the WML syntax was redesigned to be friendly to TypeScript syntax
providing for features like type assertion and generic parameters etc.

## Compilation

A WML file is a single module that exports one or more "views" and/or "funs".
A "view" corresponds to an ECMAScript class that can be instantiated at runtime
and a "fun" becomes an ECMAScript function that produces UI content.

Each WML file is compiled to its own ECMAScript module, ideally in Common JS
format. 

Future implementations may target non ECMAScript platforms supporting whatever
features make sense, however in the future WML may eventually have its own
type system making it independant of TypeScript.

## Syntax

### Control Structures

#### For In

The `for in` expression allows iteration over an array and has the 
following syntax:

```ebnf
for_in    : '{%' FOR value? index? source? IN expression '%}'
                children 
            '{%' ENDFOR '%}'

          | '{%' FOR value? index? source? IN expression '%}'
               children 
            '{%' ELSE '%}' 
               children 
            '{%' ENDFOR '%}'
          ;
```

When compiled, a `for in` loop must be an expression with the resulting
type being an array of child content.

The `else` part is optional and if present must provide the value of the loop
if the resulting array of child content is empty.

#### For Of

The `for of` expression is the same as the `for in` except iterates over
the keys of an object (map/collection) etc.

### Declarations

### View Statement

The `view` directive allows for the definition of a new wml view.

A `view` is compiled to a class or function or object on the target platform
capabable of representing a reusable a UI component in the platform environment.

A method for retrieving individual widgets/nodes contained in that UI component
should be provided.

The `view` directive has the following syntax:

```ebnf

view     : '{%' VIEW identifier type_parameter* ('(' type ')') %} tag

```

Where identifier is an unqualified capitalized identifier and type represents
the contextual type of the view. A `view` directive must be followed by
exactly one `tag`.

This tag is called the `root` of the `view`.

The token `@` can be used within the root to refer to the context of the view
and its properties.

#### Fun Statement

The `fun` directive allows for the definition of a wml function.

A function is compiled to a platform function that 
produces one or more items of Content that can be re-used elsewhere
in a module. This is useful in avoiding repeating the same syntax in a module.

WML functions are curried however platform implementation of currying is
dependant on the target platform.

The `fun` directive has the following syntax:

```ebnf
fun      : '{%' FUN identifier type_parameter* ('(' parameter ')')* = content '%}'

         | '{%' FUN identifier type_parameter* ('(' parameter ')')*  '%}'
            content+
           '{% endfun %}'
         ;
```

Where identifier is a lowercase unqualified identifier.
