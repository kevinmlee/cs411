%{
#include <stdio.h>
int yylex();
%}

%token t_bool
%token t_break
%token t_class
%token t_double
%token t_else
%token t_extends
%token t_for
%token t_if
%token t_implements
%token t_int
%token t_interface
%token t_newarray
%token t_println
%token t_readln
%token t_return
%token t_string
%token t_void
%token t_while
%token t_plus
%token t_minus
%token t_multiplication
%token t_division
%token t_mod
%token t_less
%token t_lessequal
%token t_greater
%token t_greaterequal
%token t_equal
%token t_notequal
%token t_and
%token t_or
%token t_not
%token t_assignop
%token t_semicolon
%token t_comma
%token t_period
%token t_leftparen
%token t_rightparen
%token t_leftbracket
%token t_rightbracket
%token t_leftbrace
%token t_rightbrace
%token t_boolconstant
%token t_intconstant
%token t_doubleconstant
%token t_stringconstant
%token identifier

%right t_assignop
%left t_or
%left t_and
%right t_equal t_notequal
%nonassoc t_less t_greater t_lessequal t_greaterequal
%left t_plus t_minus
%left t_multiplication t_division

%%

Program: Dec { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  ;

Dec: Dec Decl { $$ = $2; printf("[Reduce %i%s",yyn,"]");}
    | Decl { printf("[Reduce %i%s",yyn,"]");}
    ;

Decl: VariableDecl { $$ = $1; printf("[Reduce %i%s",yyn,"]");} 
    | FunctionDecl { $$ = $1; printf("[Reduce %i%s",yyn,"]");} 
    | ClassDecl { $$ = $1; printf("[Reduce %i%s",yyn,"]");} 
    | InterfaceDecl { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    ;

VariableDecls: VariableDecl VariableDecls { printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

VariableDecl: Variable ";" { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    ;

Variable: Type identifier  { $$ = $2; printf("[Reduce %i%s",yyn,"]");}
    ;

Type: bool    { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | int     { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | double  { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | string  { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | Type "[" "]" { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | identifier       { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    ;

FunctionDecl: Type identifier  "(" Formals ")" StmtBlock { printf("[Reduce %i%s",yyn,"]");}
    | void identifier  "(" Formals ")" StmtBlock { printf("[Reduce %i%s",yyn,"]");}
    ;

Formals: Formals "," Variable { $$ = $1; printf("[Reduce %i%s",yyn,"]");} 
    | Variable { printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

ClassDecl: class identifier Extends Implements "{" Field "}" { printf("[Reduce %i%s",yyn,"]");} 
    ;

Extends: extends identifier  { $$ = $2; printf("[Reduce %i%s",yyn,"]");}
    |                     { printf("[Reduce %i%s",yyn,"]");}
    ;

Implements: implements IDList { $$= $2; printf("[Reduce %i%s",yyn,"]");}
    |   { printf("[Reduce %i%s",yyn,"]");}
    ;

IDList: identifier "," IDList  { $$ =$1; printf("[Reduce %i%s",yyn,"]");}
    |  identifier { $$ =$1; printf("[Reduce %i%s",yyn,"]");}
    ;

Field: VariableDecl { printf("[Reduce %i%s",yyn,"]");} 
    | FunctionDecl { printf("[Reduce %i%s",yyn,"]");}
    |   { printf("[Reduce %i%s",yyn,"]");}
    ;

InterfaceDecl: interface id "{" Prototypes "}" { printf("[Reduce %i%s",yyn,"]");} 
    | interface identifier "{" "}" { printf("[Reduce %i%s",yyn,"]");}
    ;

Prototypes: Prototype Prototypes { printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

Prototype: Type identifier "(" Formals ")" ";" { printf("[Reduce %i%s",yyn,"]");} 
    | void identifier "(" Formals ")" ";" { printf("[Reduce %i%s",yyn,"]");}
    ;

StmtBlock: "{" VariableDecls Stmts "}" { printf("[Reduce %i%s",yyn,"]");} 
    ;

Stmts: Stmts Stmt { printf("[Reduce %i%s",yyn,"]");}
    | Stmt { printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

Stmt: ExprOrEmpty ";" { printf("[Reduce %i%s",yyn,"]");}
    | IfStmt { printf("[Reduce %i%s",yyn,"]");} 
    | WhileStmt { printf("[Reduce %i%s",yyn,"]");} 
    | ForStmt { printf("[Reduce %i%s",yyn,"]");} 
    | BreakStmt { printf("[Reduce %i%s",yyn,"]");} 
    | ReturnStmt { printf("[Reduce %i%s",yyn,"]");} 
    | PrintStmt { printf("[Reduce %i%s",yyn,"]");} 
    | StmtBlock { printf("[Reduce %i%s",yyn,"]");}
    ;

IfStmt: if "(" Expr ")" Stmt { printf("[Reduce %i%s",yyn,"]");} 
    | if "(" Expr ")" Stmt else Stmt { printf("[Reduce %i%s",yyn,"]");}
    ;

WhileStmt: while "(" Expr ")" Stmt
    ;

ForStmt: for "(" ExprOrEmpty ";" Expr ";" ExprOrEmpty ")" Stmt { $$ =$3+$5+$7+$9; printf("[Reduce %i%s",yyn,"]");} 
    ;

BreakStmt: break ";" 
  ;

ReturnStmt: return ExprOrEmpty ";" { printf("[Reduce %i%s",yyn,"]");} 
    ;

PrintStmt: println "(" ExprList ")" ";" { printf("[Reduce %i%s",yyn,"]");} 
    ;

ExprList: ExprList "," Expr { $$ = $1+$3; printf("[Reduce %i%s",yyn,"]");}
    | Expr { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    ;

ExprOrEmpty: Expr { $$=$1; printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

Expr: Lvalue "=" Expr { printf("[Reduce %i%s",yyn,"]");} 
    | Constant { printf("[Reduce %i%s",yyn,"]");} 
    | Lvalue { printf("[Reduce %i%s",yyn,"]");} 
    | Call { printf("[Reduce %i%s",yyn,"]");} 
    | "(" Expr ")" { printf("[Reduce %i%s",yyn,"]");}
    | Expr "+" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "-" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "*" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "/" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "%" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "|" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "&" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "!" Expr { printf("[Reduce %i%s",yyn,"]");}
    | "-" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "<" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "<=" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr ">" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr ">=" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "==" Expr { printf("[Reduce %i%s",yyn,"]");}
    | Expr "!=" Expr { printf("[Reduce %i%s",yyn,"]");}
    | readln "(" ")" { printf("[Reduce %i%s",yyn,"]");}
    | newarray "(" integer "," Type ")" { printf("[Reduce %i%s",yyn,"]");}
    ;

Lvalue: identifier { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | Expr "[" Expr "]" { $$ = $1 + $3; printf("[Reduce %i%s",yyn,"]");}
    | Expr "." identifier { $$ = $1 + $3; printf("[Reduce %i%s",yyn,"]");}
    ;

Call: identifier "(" Actuals ")" { $$ = $1+$3; printf("[Reduce %i%s",yyn,"]");} 
    | identifier "." identifier "(" Actuals ")" { $$ = $1+$3+$5; printf("[Reduce %i%s",yyn,"]");}
    ;

Actuals: Expr { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
    | Expr "," Actuals { $$ = $1+$3; printf("[Reduce %i%s",yyn,"]");}
    | { printf("[Reduce %i%s",yyn,"]");}
    ;

Constant: integer { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  | double { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  | string { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  | true { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  | false { $$ = $1; printf("[Reduce %i%s",yyn,"]");}
  ;

%%

int main() { yyparse(); }
yyerror(s)
char *s; { printf("bison error: %s\n", s); }
yywrap() { return(0); }