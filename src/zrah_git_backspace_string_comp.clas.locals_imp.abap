*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class stack DEFINITION
final
create PUBLIC.

PUBLIC SECTION.
METHODS:
    constructor IMPORTING initial_string type string OPTIONAL,
    push IMPORTING element type c,
    pop,
    get RETURNING VALUE(string) type string .
PROTECTED SECTION.
PRIVATE SECTION.
    data: s type string,
          h type i.         "stack height

ENDCLASS.

class stack IMPLEMENTATION.
  METHOD constructor.
    s = initial_string.
    h = strlen( s ).
  ENDMETHOD.

  METHOD get.
    string = s.
  ENDMETHOD.

  METHOD pop.
    if h > 0.
        h = h - 1.
    endif.

    s = s(h).

  ENDMETHOD.

  METHOD push.
    h = h + 1.
    s = |{ s }{ element }|.
  ENDMETHOD.

ENDCLASS.
