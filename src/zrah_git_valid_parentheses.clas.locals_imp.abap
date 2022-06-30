*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_stack definition.
public section.
methods:
    push importing iv_char type string,
    pop importing iv_char type string,
    get RETURNING VALUE(rv_char) type string,
    get_height returning value(rv_height) type i.

private section.
data: gv_stack type string.


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
endif.
endmethod.

method get.
    if gv_stack is not initial.
        data(lv_height) = strlen( gv_stack ) - 1.
        rv_char = gv_stack+lv_height(1).
    endif.
endmethod.

method get_height.
    rv_height = strlen( gv_stack ).
endmethod.
endclass.
