CLASS zrah_git_two_sum DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF int_row,
        index   TYPE i,
        element TYPE i,
      END OF int_row,
      BEGIN OF diff_row,
        index   TYPE i,
        element TYPE i,
      END OF diff_row,
      int_table_type  TYPE STANDARD TABLE OF int_row WITH DEFAULT KEY,
      diff_table_type TYPE STANDARD TABLE OF diff_row WITH UNIQUE HASHED KEY k1 COMPONENTS element.

    INTERFACES: if_oo_adt_classrun.

    METHODS:
      get_indexes
        IMPORTING
          int_table TYPE int_table_type
          sum       TYPE i
        EXPORTING
          index1    TYPE i
          index2    TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrah_git_two_sum IMPLEMENTATION.
  METHOD get_indexes.
    DATA: diff_table TYPE diff_table_type.
    diff_table = VALUE #( FOR i IN int_table (  element = sum - i-element
                                                index = i-index ) ).

    LOOP AT int_table REFERENCE INTO DATA(line).
      index1 = sy-tabix.
      TRY.
          DATA(diff_line) = diff_table[ KEY k1 COMPONENTS element = line->element ].
        CATCH cx_sy_itab_line_not_found.
          CONTINUE.
      ENDTRY.
      index2 = diff_line-index.
      EXIT.
    ENDLOOP.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA: a TYPE string VALUE 'a#c',
          b TYPE string VALUE 'b'.

    get_indexes( EXPORTING int_table  = VALUE #( ( index = 1 element = 2 )
                                                 ( index = 2 element = 3 )
                                                 ( index = 3 element = 4 )
                                                 ( index = 4 element = 5 ) )
                           sum = 7
               IMPORTING index1 = DATA(index1)
                         index2 = DATA(index2) ).

    out->write( |index1 = { index1 }, index2 = { index2 }| ).

  ENDMETHOD.

ENDCLASS.

