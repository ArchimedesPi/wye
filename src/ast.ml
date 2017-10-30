type binary_operator =
  | Addition
  | Subtraction
  | Multiplication
  | Division
  | Equal
  | NotEqual
  | GreaterThan
  | LessThan
  | GreaterThanEqual
  | LessThanEqual
[@@deriving show];;

type qualifier =
  | Mut
  | Const
[@@deriving show];;

(* function argument :: argname; typehint option *)
type argdef = string * string option [@@deriving show];;
type proto = Prototype of string * argdef list [@@deriving show];;

(* module path :: [submodule] *)
type modpath = string list [@@deriving show];;
(* identifier :: name; module option *)
type ident = string * modpath [@@deriving show];;

type ast =
(* root types *)
  (* variant for numeric literals *)
  | Number of [`Int of int | `Float of float]
  | Variable of ident
  | Message of ident
  | String of string
(**)
  | Call of ident * ast list
  | FuncBind of proto * ast list
  | VarBind of ident * ast * qualifier option
(* === operators === *)
  (* binary operation :: operator; lhs; rhs *)
  | BinaryOp of binary_operator * ast * ast
(* === meta === *)
  (* using :: module; as option *)
  | Using of string * string option
  | Useless
[@@deriving show];;


(* a program is a flat collection of ASTs *)
type program = ast list [@@deriving show];;
