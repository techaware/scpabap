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
      data: A type string value 'a#cs#b',
            B type string value 'k#dsdd###b'.

    out->write( | A and B are { cond string( let z = compare( A = a B = b ) in when z = abap_true then 'equal' else 'not equal' ) } | ).
  ENDMETHOD.

  METHOD compare.
    data: astack type ref to stack,
          bstack type ref to stack,
          i type i,
          j type i,
          c type c.

    astack = new #( A ).
    bstack = new #( B ).


    if astack->get( ) = bstack->get( ).
        equal = abap_true.
    else.
        equal = abap_false.
    endif.
  ENDMETHOD.

ENDCLASS..
