*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS stack DEFINITION
FINAL
CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING initial_string TYPE string OPTIONAL,
      get RETURNING VALUE(string) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: s TYPE string,
          h TYPE i.         "stack height
    METHODS:
      push IMPORTING element TYPE c,
      pop.

ENDCLASS.

CLASS stack IMPLEMENTATION.
  METHOD constructor.

    data: i type i,
          c type c.

*   build the stack for the initial string
    while i < strlen( initial_string ).
        c = initial_string+i(1).
        if c = '#'.
            me->pop(  ).
        else.
            me->push( c ).
        endif.
        i = i + 1.
    ENDWHILE.

  ENDMETHOD.

  METHOD get.
    string = s.
  ENDMETHOD.

  METHOD pop.
    IF h > 0.
      h = h - 1.
    ENDIF.

    s = s(h).

  ENDMETHOD.

  METHOD push.
    h = h + 1.
    s = |{ s }{ element }|.
  ENDMETHOD.

ENDCLASS.
