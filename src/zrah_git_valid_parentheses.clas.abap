CLASS zrah_git_valid_parentheses DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    interfaces:
        if_oo_adt_classrun.

    methods:
        is_valid importing iv_input type string
                returning value(rv_is_valid) type abap_bool,
        is_open importing iv_char type string
        returning value(rv_is_open) type abap_bool,
        is_close importing iv_char type string
        returning value(rv_is_close) type abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrah_git_valid_parentheses IMPLEMENTATION.

  METHOD is_valid.
    " parse the string
    data(i) = 0.
    data(lo_stack) = new lcl_stack( ).

    while i < strlen( iv_input ).

        data(this) = iv_input+i(1).

        if is_open( this ) eq abap_true.
            lo_stack->push( this ).
        endif.

        if is_close( this ) eq abap_true.
            lo_stack->pop( this ).
        endif.

        i = i + 1.

    endwhile.

    rv_is_valid = lo_stack->get_valid( ).

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    out->write( is_valid( '((((([]){}))))' ) ).
  ENDMETHOD.

  method is_open.

  if iv_char eq '('
  or iv_char eq '{'
  or iv_char eq '['.
    rv_is_open = abap_true.
  endif.

  endmethod.

  method is_close.

  if iv_char eq ')'
  or iv_char eq '}'
  or iv_char eq ']'.
    rv_is_close = abap_true.
  endif.

  endmethod.
ENDCLASS.
