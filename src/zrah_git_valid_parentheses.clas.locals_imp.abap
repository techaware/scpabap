*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_stack definition.
public section.
methods:
    push importing iv_char type string,
    pop importing iv_char type string,
    get RETURNING VALUE(rv_char) type string,
    get_valid returning value(rv_valid) type abap_boolean.

private section.
data: gv_stack type string,
      gv_invalid type abap_boolean.


endclass.

class lcl_stack implementation.

method push.
if iv_char eq '(' or iv_char eq '{' or iv_char eq '['.
    gv_stack = |{ gv_stack }{ iv_char }|.
endif.
endmethod.

method pop.
if ( get( ) eq '(' and iv_char eq ')' )
or ( get( ) eq '{' and iv_char eq '}' )
or ( get( ) eq '[' and iv_char eq ']' ) .
    data(lv_height) = strlen( gv_stack ) - 1.
    gv_stack = gv_stack(lv_height).
else.
    gv_invalid = abap_true.
endif.

endmethod.

method get.
    if gv_stack is not initial.
        data(lv_height) = strlen( gv_stack ) - 1.
        rv_char = gv_stack+lv_height(1).
    endif.
endmethod.

method get_valid.


    rv_valid = xsdbool( strlen( gv_stack ) = 0 AND  gv_invalid = abap_false ).

endmethod.
endclass.
