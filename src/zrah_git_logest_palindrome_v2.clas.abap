CLASS zrah_git_logest_palindrome_v2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES:
  if_oo_adt_classrun.

  methods:
  find IMPORTING iv_string type string
  RETURNING VALUE(rv_longest_palindrome) type string,
  append_find importing iv_string type string
  RETURNING VALUE(rv_longest_palindrome) type string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrah_git_logest_palindrome_v2 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    data: lv_string type string,
          lv_sub_length type i.
    lv_string = 'ABA1X2X1'.
    lv_sub_length = 1.
    data(i) = 0.
    while i < strlen( lv_string ).
        data(lv_sub_string) = lv_string+i(lv_sub_length).
        data(j) = i + 1.
        out->write( |Input:{ lv_string(j) }; Output: { append_find( lv_sub_string ) } | ).
        i = i + 1.
    endwhile.
  ENDMETHOD.

  METHOD find.

* Parse the string and create fold structure
  data(lo_fold) = lcl_fold=>get_instance( ).

  lo_fold->execute( iv_string ).

* get the longest palindrome
  rv_longest_palindrome = lo_fold->get_longest( ).

  ENDMETHOD.

  METHOD append_find.
* Parse the string and create fold structure
  data(lo_fold) = lcl_fold=>get_instance( ).

  lo_fold->execute_delta( iv_string ).

* get the longest palindrome
  rv_longest_palindrome = lo_fold->get_longest( ).
  ENDMETHOD.

ENDCLASS.
