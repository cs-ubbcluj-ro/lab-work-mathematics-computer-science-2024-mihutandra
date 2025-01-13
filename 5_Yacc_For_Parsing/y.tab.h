/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IDENTIFIER = 258,
     INT_CONST = 259,
     STRING_LITERAL = 260,
     PLUS = 261,
     MINUS = 262,
     MUL = 263,
     DIV = 264,
     MOD = 265,
     ASSIGN = 266,
     CIN = 267,
     COUT = 268,
     IF = 269,
     ELSE = 270,
     WHILE = 271,
     FOR = 272,
     DO = 273,
     RETURN = 274,
     CONST = 275,
     LBRACE = 276,
     RBRACE = 277,
     LPAREN = 278,
     RPAREN = 279,
     SEMICOLON = 280,
     GT = 281,
     LT = 282,
     GTE = 283,
     LTE = 284,
     EQ = 285,
     NEQ = 286,
     BOOL = 287,
     CHAR = 288,
     STRING = 289,
     INT = 290,
     TRUE = 291,
     FALSE = 292,
     RSHIFT = 293,
     LSHIFT = 294,
     MAIN = 295,
     OR = 296,
     AND = 297,
     NOT = 298
   };
#endif
/* Tokens.  */
#define IDENTIFIER 258
#define INT_CONST 259
#define STRING_LITERAL 260
#define PLUS 261
#define MINUS 262
#define MUL 263
#define DIV 264
#define MOD 265
#define ASSIGN 266
#define CIN 267
#define COUT 268
#define IF 269
#define ELSE 270
#define WHILE 271
#define FOR 272
#define DO 273
#define RETURN 274
#define CONST 275
#define LBRACE 276
#define RBRACE 277
#define LPAREN 278
#define RPAREN 279
#define SEMICOLON 280
#define GT 281
#define LT 282
#define GTE 283
#define LTE 284
#define EQ 285
#define NEQ 286
#define BOOL 287
#define CHAR 288
#define STRING 289
#define INT 290
#define TRUE 291
#define FALSE 292
#define RSHIFT 293
#define LSHIFT 294
#define MAIN 295
#define OR 296
#define AND 297
#define NOT 298




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

