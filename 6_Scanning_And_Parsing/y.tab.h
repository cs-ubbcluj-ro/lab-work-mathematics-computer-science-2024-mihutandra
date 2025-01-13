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
     INT = 258,
     BOOL = 259,
     CHAR = 260,
     STRING = 261,
     IF = 262,
     ELSE = 263,
     CONST = 264,
     DO = 265,
     WHILE = 266,
     CIN = 267,
     COUT = 268,
     RETURN = 269,
     FOR = 270,
     IDENTIFIER = 271,
     INT_CONST = 272,
     STRING_LITERAL = 273,
     TRUE = 274,
     FALSE = 275,
     PLUS = 276,
     MINUS = 277,
     MUL = 278,
     DIV = 279,
     ASSIGN = 280,
     EQ = 281,
     NEQ = 282,
     LT = 283,
     LTE = 284,
     GT = 285,
     GTE = 286,
     MOD = 287,
     AND = 288,
     OR = 289,
     NOT = 290,
     SEMICOLON = 291,
     LBRACE = 292,
     RBRACE = 293,
     LPAREN = 294,
     RPAREN = 295,
     STREAMOUT = 296,
     STREAMIN = 297,
     MAIN = 298,
     LSQUARE = 299,
     RSQUARE = 300,
     COMMA = 301
   };
#endif
/* Tokens.  */
#define INT 258
#define BOOL 259
#define CHAR 260
#define STRING 261
#define IF 262
#define ELSE 263
#define CONST 264
#define DO 265
#define WHILE 266
#define CIN 267
#define COUT 268
#define RETURN 269
#define FOR 270
#define IDENTIFIER 271
#define INT_CONST 272
#define STRING_LITERAL 273
#define TRUE 274
#define FALSE 275
#define PLUS 276
#define MINUS 277
#define MUL 278
#define DIV 279
#define ASSIGN 280
#define EQ 281
#define NEQ 282
#define LT 283
#define LTE 284
#define GT 285
#define GTE 286
#define MOD 287
#define AND 288
#define OR 289
#define NOT 290
#define SEMICOLON 291
#define LBRACE 292
#define RBRACE 293
#define LPAREN 294
#define RPAREN 295
#define STREAMOUT 296
#define STREAMIN 297
#define MAIN 298
#define LSQUARE 299
#define RSQUARE 300
#define COMMA 301




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

