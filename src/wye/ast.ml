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


(* function argument :: argname; typehint option *)
type fun_arg = FunctionArgument of string * string option [@@deriving show];;
(* function arguments :: [argument] *)
type fun_args = FunctionArguments of fun_arg array [@@deriving show];;

type ast = (* all the root ast types *)
  (* variant for numeric literals *)
  | Number of [`Int of int | `Float of float]
  | Variable of string
  | String of string
  (* binary operation :: operator; lhs; rhs *)
  | BinaryOp of binary_operator * ast * ast
  (* functions *)
  | FunctionDefinition of fun_args * ast
[@@deriving show];;

type program = ast list [@@deriving show];;
