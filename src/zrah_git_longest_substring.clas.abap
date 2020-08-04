CLASS zrah_git_longest_substring DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_oo_adt_classrun.

    METHODS:
      longest_substring IMPORTING iv_input           TYPE string
                        RETURNING VALUE(r_substring) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zrah_git_longest_substring IMPLEMENTATION.
  METHOD longest_substring.
    TYPES: BEGIN OF lty_hash,
             character(1) TYPE c,
             start        TYPE i,
             end          TYPE i,
           END OF lty_hash,
           ltt_hash TYPE HASHED TABLE OF lty_hash WITH UNIQUE KEY character.
    DATA: lt_hash TYPE ltt_hash,
          index   TYPE i,
          max     TYPE  i.

    DATA(size) = strlen( iv_input ).

    WHILE index LE ( size - 1 ).
      DATA(index_char) = iv_input+index(1).
      IF line_exists( lt_hash[ character = index_char ] ).
        DATA(start) = lt_hash[ character = index_char ]-start.
        IF max LT ( index - start ).
          max = index - start.
          r_substring = iv_input+start(max).
        ENDIF.
*       restart from current
        CLEAR lt_hash.
        INSERT VALUE #( character = index_char start = index ) INTO TABLE lt_hash.
      ELSE.
        INSERT VALUE #( character = index_char start = index ) INTO TABLE lt_hash.
      ENDIF.
      index = index + 1.
    ENDWHILE.
  ENDMETHOD.
  METHOD if_oo_adt_classrun~main.
    out->write( longest_substring( 'abcabcbb' ) ).
    out->write( longest_substring( 'pwwkew' ) ).
    out->write( longest_substring( 'bbbbb' ) ).
  ENDMETHOD.

ENDCLASS.
