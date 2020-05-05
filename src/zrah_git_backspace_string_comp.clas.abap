CLASS zrah_git_backspace_string_comp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES: if_oo_adt_classrun.

  METHODS:
    compare IMPORTING A type string
                      B type string
            RETURNING VALUE(equal) type abap_boolean.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrah_git_backspace_string_comp IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
      data: A type string value 'a#c',
            B type string value 'b'.

    out->write( |A and B are equal: { compare( A = a B = b ) }| ).
  ENDMETHOD.

  METHOD compare.
    data: astack type ref to stack,
          bstack type ref to stack,
          i type i,
          j type i,
          c type c.

    astack = new #( ).
    bstack = new #( ).

    while i < strlen( A ).
        c = A+i(1).
        if c = '#'.
            astack->pop(  ).
        else.
            astack->push( c ).
        endif.
        i = i + 1.
    ENDWHILE.

     while j < strlen( B ).
        c = B+j(1).
        if  c = '#'.
            bstack->pop(  ).
        else.
            bstack->push( c ).
        endif.
        j = j + 1.
    ENDWHILE.

    if astack->get( ) = bstack->get( ).
        equal = abap_true.
    else.
        equal = abap_false.
    endif.
  ENDMETHOD.

ENDCLASS.
