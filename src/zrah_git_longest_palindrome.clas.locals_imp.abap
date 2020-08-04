*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS palindrome IMPLEMENTATION.
  METHOD constructor.
    s = palindrome_string.
    l = strlen( s ).
  ENDMETHOD.

  METHOD create.
*    “ s = string
*    “ c = center.
    DATA(i) = 0.
*     check odd palindrome
    WHILE i LE ( c - 2 ).
      DATA(left_pos) = c - i - 2.
      DATA(right_pos) = c + i.
      IF s+left_pos(1) NE s+right_pos(1).
*        “ palindrome ends
        EXIT.
      ENDIF.
      DATA(palindrome_start) = left_pos.
      DATA(palindrome_length) = 2 * ( i + 1 ) + 1.
      i = i + 1.
    ENDWHILE.

    IF i = 0.
*      “ check even palindrome
      WHILE i LE ( c - 2 ).
        left_pos = c - i - 1.
        right_pos = c + i.
        IF s+left_pos(1) NE s+right_pos(1).
*        “ palindrome ends
          EXIT.
        ENDIF.
        palindrome_start = left_pos.
        palindrome_length = 2 * ( i + 1 ).
        i = i + 1.
      ENDWHILE.
    ENDIF.

    IF i > 0.
      DATA(ps) = s+palindrome_start(palindrome_length).
      p = NEW palindrome( ps ).
    ENDIF.
  ENDMETHOD.
  METHOD get.
    r_s = s.
  ENDMETHOD.
  METHOD length.
    r_l  = l.
  ENDMETHOD.
ENDCLASS.
