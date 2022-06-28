*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_fold DEFINITION DEFERRED.

CLASS lcl_char DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_val   TYPE string
                            iv_index TYPE i,
      get_prev RETURNING VALUE(ro_char) TYPE REF TO lcl_char,
      set_prev IMPORTING io_char TYPE REF TO lcl_char,
      get_prev_val importing iv_edge type abap_boolean optional RETURNING VALUE(rv_val) TYPE string,
      get_next  IMPORTING iv_val         TYPE string OPTIONAL
                          iv_index       TYPE i OPTIONAL
                RETURNING VALUE(ro_char) TYPE REF TO lcl_char,
      set_next IMPORTING io_char TYPE REF TO lcl_char,
      get_next_val importing iv_edge type abap_boolean optional RETURNING VALUE(rv_val) TYPE string,
      set_val IMPORTING iv_val TYPE string,
      get_val importing iv_edge type abap_boolean optional RETURNING VALUE(rv_val) TYPE string,
      get_length RETURNING VALUE(rv_length) TYPE i.


  PRIVATE SECTION.
    DATA: gv_val    TYPE string,
          gv_pal    type string,
          gv_index  TYPE i,
          gv_length TYPE i,
          go_prev   TYPE REF TO lcl_char,
          go_next   TYPE REF TO lcl_char.

ENDCLASS.

CLASS lcl_char IMPLEMENTATION.

  METHOD constructor.

    gv_val = iv_val.
    gv_pal = iv_val.
    gv_index = iv_index.
    gv_length = strlen( iv_val ).

  ENDMETHOD.

  METHOD set_prev.

    go_prev = io_char.

  ENDMETHOD.

  METHOD get_prev.

    ro_char = go_prev.

  ENDMETHOD.

  METHOD get_prev_val.

    IF go_prev IS NOT INITIAL.
      rv_val = go_prev->get_val( iv_edge ).
    ENDIF.

  ENDMETHOD.

  METHOD set_next.

    go_next = io_char.

  ENDMETHOD.


  METHOD get_next.
    " check if next exists. If not then based on index it creates one
    IF go_next IS INITIAL and iv_val is not initial.
      go_next = NEW lcl_char( iv_val = iv_val iv_index = iv_index ).
    ENDIF.
    ro_char = go_next.

  ENDMETHOD.

  METHOD get_next_val.

    IF go_next IS NOT INITIAL.
      rv_val = go_next->get_val( iv_edge ).
    ENDIF.

  ENDMETHOD.

  METHOD get_val.

    if iv_edge is initial.
        rv_val = gv_pal.
    else.
        rv_val = gv_val.
    endif.

  ENDMETHOD.


  METHOD set_val.

    " val is just the edge of the pal
    gv_val = iv_val(1).

    gv_pal = iv_val.
    gv_length = strlen( gv_pal ).

  ENDMETHOD.

  METHOD get_length.

    rv_length = gv_length.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_fold DEFINITION FINAL
CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
     get_instance
      RETURNING
        VALUE(ro_fold) TYPE REF TO lcl_fold,
     delete_instance.

    METHODS:
      execute
        IMPORTING
          iv_string TYPE string,
      execute_delta
        IMPORTING
          iv_string TYPE string,
      get_char IMPORTING iv_index      TYPE i
               RETURNING VALUE(rv_val) TYPE string,
      get_longest
        RETURNING
          VALUE(rv_longest) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      gv_string     TYPE string,
      gv_max_length TYPE i,
      gv_max_fold   TYPE string.

    DATA: i               TYPE i,
          go_this         TYPE REF TO lcl_char,
          go_prev         TYPE REF TO lcl_char,
          go_next         TYPE REF TO lcl_char.

    CLASS-DATA: go_fold TYPE REF TO lcl_fold.

ENDCLASS.

CLASS lcl_fold IMPLEMENTATION.


  METHOD get_char.

    IF iv_index < strlen( gv_string ).
      rv_val = gv_string+iv_index(1).
    ENDIF.

  ENDMETHOD.

  METHOD get_instance.

*   create fold instance (singleton)
    IF go_fold IS INITIAL.
      go_fold = NEW #( ).
    ENDIF.
      ro_fold = go_fold.
  ENDMETHOD.

  METHOD execute.

*   keep a copy

    me->gv_string = |{ me->gv_string }{ iv_string }|.

    DATA(lv_strlen) = strlen( me->gv_string ).

    WHILE i < lv_strlen.

      " initialize this
      IF go_this IS INITIAL.
        DATA(lv_char) = gv_string+i(1).
        go_this = NEW lcl_char( iv_val = lv_char iv_index = i ).
      ENDIF.

      " bind with prev
      IF go_prev IS NOT INITIAL.
        go_this->set_prev( go_prev ).
        go_prev->set_next( go_this ).
      ENDIF.

      data(j) = i.

      WHILE go_this->get_prev( ) IS NOT INITIAL
      AND go_this->get_next( iv_val = me->get_char( j + 1 ) iv_index = j + 1 ) IS NOT INITIAL
      AND go_this->get_prev_val( abap_true ) = go_this->get_next_val( abap_true ).
        "concatenate prev/this/next and update as this
        go_this->set_val( |{ go_this->get_prev_val( ) }{ go_this->get_val( ) }{ go_this->get_next_val( ) }| ).
        go_this->set_prev( go_this->get_prev( )->get_prev( ) ).
        go_this->set_next( go_this->get_next( )->get_next( ) ).
        "for each fold we jump the index by one
        j = j + 1.
      ENDWHILE.


      IF go_this->get_length( ) > me->gv_max_length.

        me->gv_max_length = go_this->get_length( ).
        me->gv_max_fold = go_this->get_val( ).

      ENDIF.

      " Move to next knowing that a fold might have happened. So, next is a jump.
      if i < lv_strlen - 1.
        go_prev = go_this.
        go_this = go_this->get_next( iv_val = me->get_char( j + 1 ) iv_index = j + 1 ).
      endif.

        i = j + 1.

    ENDWHILE.

  ENDMETHOD.


  METHOD get_longest.
* get longest fold
    rv_longest = gv_max_fold.

  ENDMETHOD.

  METHOD delete_instance.
    clear go_fold.
  ENDMETHOD.

  METHOD execute_delta.

* delta run is same as execute. It starts at char before last.

    if i > 0.
        i = i - 1.
    endif.

    execute( iv_string ).

  ENDMETHOD.

ENDCLASS.
