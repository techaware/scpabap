CLASS zrah_git_string_reverse DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  TYPES: ty_s(100) type c.
  INTERFACES: if_oo_adt_classrun.
  METHODS:
    reverse changing s type ty_s.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrah_git_string_reverse IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.
    data: s type ty_s.
*    data(user_input) = out->get( ).
    s = 'This is awesome'.
    reverse( changing s = s ).
    out->write( s ).
ENDMETHOD.

METHOD reverse.
  field-symbols: <e> type any,
                 <s> type any.
  data: t type c.
  data(l) = strlen( s ).
* decrementing index
  l = l - 1.
* incrementing index
  data(b) = 0.

* repeat until incrementing index is less that decrementing index
  while b < l.
* first char
    assign s+b(1) to <s> casting type c.
* last char
    assign s+l(1) to <e> casting type c.

*   Swap first and last
    t   = <e>.
    <e> = <s>.
    <s> = t.

*   update index
    b = b + 1.
    l = l - 1.
  endwhile.
ENDMETHOD.
ENDCLASS.
