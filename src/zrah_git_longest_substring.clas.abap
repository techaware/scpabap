CLASS zrah_git_longest_substring DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_oo_adt_classrun.

    METHODS:
      longest importing iv_input type string
                        RETURNING VALUE(r_substring) type string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zrah_git_longest_substring IMPLEMENTATION.

  method longest.

  types: begin of lty_hash,
            character(1) type c,
            index type i,
        end of lty_hash,
        ltt_hash TYPE HASHED TABLE OF lty_hash WITH UNIQUE KEY character.

  data: lt_hash type ltt_hash,
        max_substring type string.

  check iv_input is not initial.

* iterate over the string
  data(i) = 0.
  data(strlen) = strlen( iv_input ).

  while i < strlen.

  " access a char
    data(this) = iv_input+i(1).

  " check if already seen
    if line_exists( lt_hash[ character = this ] ).
        data(index) = lt_hash[ character = this ]-index.
        clear lt_hash.
        clear max_substring.
        "retart from index  + 1.
        i = index + 1.
    else.
        insert value #( character = this index = i ) into table lt_hash.
        max_substring = |{ max_substring }{ this }|.
        i = i + 1.
    endif.

    if strlen( r_substring ) < strlen( max_substring ).
        r_substring = max_substring.
    endif.

  endwhile.

  endmethod.

  METHOD if_oo_adt_classrun~main.
    out->write( longest( 'abcabcbb' ) ).
    out->write( longest( 'pwwkew' ) ).
    out->write( longest( 'bbbbb' ) ).
    out->write( longest( 'ABCD' ) ).
    out->write( longest( 'ABCDABCDEFA' ) ).
    out->write( longest( 'A' ) ).
    out->write( longest( '' ) ).
  ENDMETHOD.

ENDCLASS.
