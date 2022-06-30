CLASS zrah_git_zigzag DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.

    METHODS:
      transform IMPORTING iv_input         TYPE string
                          iv_rows          TYPE i
                RETURNING VALUE(rv_output) TYPE string.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrah_git_zigzag IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    out->write(
      EXPORTING
        data   = transform( iv_input = 'PAYPALISHIRING' iv_rows = 3 )
    ).
  ENDMETHOD.

  METHOD transform.

    TYPES: BEGIN OF lty_output,
             substring TYPE string,
           END OF lty_output,
           ltt_output TYPE STANDARD TABLE OF lty_output.

    DATA: lt_output TYPE ltt_output.

    " go through the input sequencially and start adding the char to correct row.

    DATA(i) = 0.
    DATA(r) = 1. "row tracker
    DATA(d) = 'D'. "Direction

    DATA(strlen) = strlen( iv_input ).

    WHILE i < strlen.

      "access char
      DATA(this) =  iv_input+i(1).
      READ TABLE lt_output ASSIGNING FIELD-SYMBOL(<fs_row>) INDEX r.
      IF sy-subrc = 0 and <fs_row> IS ASSIGNED.
        <fs_row>-substring = |{ <fs_row>-substring }{ this }|.
      ELSE.
        APPEND INITIAL LINE TO lt_output ASSIGNING <fs_row>.
        <fs_row>-substring = this.
      ENDIF.

      IF d = 'D'.
        IF r < iv_rows.
          r = r + 1.
        ELSE.
          d = 'U'.
        ENDIF.
      ENDIF.

      IF d = 'U'.
        IF r > 1.
          r = r - 1.
        ELSE.
          d = 'D'.
          r = r + 1.
        ENDIF.
      ENDIF.


      i = i + 1.

    ENDWHILE.

    " compose the output from lt_output
    loop at lt_output ASSIGNING <fs_row>.
        rv_output = |{ rv_output }{ <fs_row>-substring }|.
    endloop.

  ENDMETHOD.

ENDCLASS.
