*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section
CLASS palindrome DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      create IMPORTING s        TYPE string
                       c        TYPE i
             RETURNING VALUE(p) TYPE REF TO palindrome.
    METHODS:
      constructor IMPORTING palindrome_string TYPE string,
      get RETURNING VALUE(r_s) TYPE string,
      length RETURNING VALUE(r_l) TYPE i.

  PRIVATE SECTION.
    DATA:
      s TYPE string,
      l TYPE i.
ENDCLASS.
