-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParLI where
import qualified AbsLI
import LexLI
}

%name pProgram Program
%name pClassDeclaration ClassDeclaration
%name pMemberDeclaration MemberDeclaration
%name pDecl Decl
%name pListStm ListStm
%name pListClassDeclaration ListClassDeclaration
%name pListMemberDeclaration ListMemberDeclaration
%name pListDecl ListDecl
%name pListExp ListExp
%name pStm Stm
%name pExp1 Exp1
%name pExp2 Exp2
%name pExp3 Exp3
%name pExp4 Exp4
%name pExp5 Exp5
%name pExp6 Exp6
%name pExp7 Exp7
%name pExp8 Exp8
%name pType Type
%name pExp Exp
-- no lexer declaration
%monad { Either String } { (>>=) } { return }
%tokentype {Token}
%token
  '!' { PT _ (TS _ 1) }
  '&&' { PT _ (TS _ 2) }
  '(' { PT _ (TS _ 3) }
  '()' { PT _ (TS _ 4) }
  ')' { PT _ (TS _ 5) }
  '*' { PT _ (TS _ 6) }
  '+' { PT _ (TS _ 7) }
  '++' { PT _ (TS _ 8) }
  ',' { PT _ (TS _ 9) }
  '-' { PT _ (TS _ 10) }
  '.' { PT _ (TS _ 11) }
  '/' { PT _ (TS _ 12) }
  ';' { PT _ (TS _ 13) }
  '=' { PT _ (TS _ 14) }
  'String' { PT _ (TS _ 15) }
  'bool' { PT _ (TS _ 16) }
  'class' { PT _ (TS _ 17) }
  'else' { PT _ (TS _ 18) }
  'false' { PT _ (TS _ 19) }
  'if' { PT _ (TS _ 20) }
  'int' { PT _ (TS _ 21) }
  'new' { PT _ (TS _ 22) }
  'return' { PT _ (TS _ 23) }
  'then' { PT _ (TS _ 24) }
  'true' { PT _ (TS _ 25) }
  'void' { PT _ (TS _ 26) }
  'while' { PT _ (TS _ 27) }
  '{' { PT _ (TS _ 28) }
  '||' { PT _ (TS _ 29) }
  '}' { PT _ (TS _ 30) }
  L_Ident  { PT _ (TV $$) }
  L_integ  { PT _ (TI $$) }
  L_quoted { PT _ (TL $$) }

%%

Ident :: { AbsLI.Ident}
Ident  : L_Ident { AbsLI.Ident $1 }

Integer :: { Integer }
Integer  : L_integ  { (read ($1)) :: Integer }

String  :: { String }
String   : L_quoted { $1 }

Program :: { AbsLI.Program }
Program : ListClassDeclaration { AbsLI.Prog $1 }

ClassDeclaration :: { AbsLI.ClassDeclaration }
ClassDeclaration : 'class' Ident '{' ListMemberDeclaration '}' { AbsLI.ClassD $2 $4 }

MemberDeclaration :: { AbsLI.MemberDeclaration }
MemberDeclaration : Decl ';' { AbsLI.Attr $1 }
                  | Type Ident '(' ListDecl ')' '{' ListStm '}' { AbsLI.Mth $1 $2 $4 $7 }

Decl :: { AbsLI.Decl }
Decl : Type Ident { AbsLI.Dec $1 $2 }

ListStm :: { [AbsLI.Stm] }
ListStm : {- empty -} { [] } | Stm ListStm { (:) $1 $2 }

ListClassDeclaration :: { [AbsLI.ClassDeclaration] }
ListClassDeclaration : {- empty -} { [] }
                     | ClassDeclaration ListClassDeclaration { (:) $1 $2 }

ListMemberDeclaration :: { [AbsLI.MemberDeclaration] }
ListMemberDeclaration : {- empty -} { [] }
                      | MemberDeclaration ListMemberDeclaration { (:) $1 $2 }

ListDecl :: { [AbsLI.Decl] }
ListDecl : {- empty -} { [] }
         | Decl { (:[]) $1 }
         | Decl ',' ListDecl { (:) $1 $3 }

ListExp :: { [AbsLI.Exp] }
ListExp : {- empty -} { [] }
        | Exp { (:[]) $1 }
        | Exp ',' ListExp { (:) $1 $3 }

Stm :: { AbsLI.Stm }
Stm : Decl ';' { AbsLI.SDec $1 }
    | Exp ';' { AbsLI.SExp $1 }
    | Ident '=' Exp ';' { AbsLI.SAss $1 $3 }
    | '{' ListStm '}' { AbsLI.SBlock $2 }
    | 'while' '(' Exp ')' Stm { AbsLI.SWhile $3 $5 }
    | 'return' Exp ';' { AbsLI.SReturn $2 }
    | 'if' '(' Exp ')' 'then' Stm 'else' Stm { AbsLI.SIf $3 $6 $8 }

Exp1 :: { AbsLI.Exp }
Exp1 : Exp1 '||' Exp2 { AbsLI.EOr $1 $3 } | Exp2 { $1 }

Exp2 :: { AbsLI.Exp }
Exp2 : Exp2 '&&' Exp3 { AbsLI.EAnd $1 $3 } | Exp3 { $1 }

Exp3 :: { AbsLI.Exp }
Exp3 : '!' Exp3 { AbsLI.ENot $2 } | Exp4 { $1 }

Exp4 :: { AbsLI.Exp }
Exp4 : Exp4 '++' Exp5 { AbsLI.ECon $1 $3 }
     | Exp4 '+' Exp5 { AbsLI.EAdd $1 $3 }
     | Exp4 '-' Exp5 { AbsLI.ESub $1 $3 }
     | Exp5 { $1 }

Exp5 :: { AbsLI.Exp }
Exp5 : Exp5 '*' Exp6 { AbsLI.EMul $1 $3 }
     | Exp5 '/' Exp6 { AbsLI.EDiv $1 $3 }
     | Exp6 { $1 }

Exp6 :: { AbsLI.Exp }
Exp6 : Ident '.' Ident '(' ListExp ')' { AbsLI.EMthCall $1 $3 $5 }
     | Exp7 { $1 }

Exp7 :: { AbsLI.Exp }
Exp7 : 'new' Ident '()' { AbsLI.ENew $2 } | Exp8 { $1 }

Exp8 :: { AbsLI.Exp }
Exp8 : Integer { AbsLI.EInt $1 }
     | Ident { AbsLI.EVar $1 }
     | String { AbsLI.EStr $1 }
     | 'true' { AbsLI.ETrue }
     | 'false' { AbsLI.EFalse }
     | '(' Exp ')' { $2 }

Type :: { AbsLI.Type }
Type : 'bool' { AbsLI.Tbool }
     | 'int' { AbsLI.Tint }
     | 'void' { AbsLI.Tvoid }
     | 'String' { AbsLI.TStr }
     | Ident { AbsLI.TClass $1 }

Exp :: { AbsLI.Exp }
Exp : Exp1 { $1 }
{

happyError :: [Token] -> Either String a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer = tokens
}

