# Wye language definition
Note:
```ocaml
type modpath = string list;;
type ident = string * modpath;;
```

## Expressions
### Literals
Supported literal types:
* Integers (ast: `Number (\`Int val)`, tok: `INT`)
  Basic integer literals are supported.
  Currently no support for exponential notation or radixes other than base 10.
* Floats (ast: `Number (\`Float val)`, tok: `FLOAT`)
  Floating-point literals. Supports exponential notation.
* Strings (ast: `String val`, tok: `STR`)
  Delimited with double quotes (`"`).
  Supports the escape sequences {`\n`, `\r`, `\t`, `\\`}.

### Variable references
* Variables (ast: `Variable ident`, parsed from tok: `IDENT`)
  Any IDENT that falls through is probably a variable.

## Statements
### Bindings
* Variable Binding (ast: `VarBind ident * expr * qualifier?`)
  Parsed from `let $qualifier? $ident = $expr`.
