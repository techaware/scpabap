CLASS zrah_git_longest_palindrome DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_oo_adt_classrun.

    METHODS:
      find IMPORTING s            TYPE string
           RETURNING VALUE(max_s) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
    longest_palindorme TYPE REF TO palindrome.
ENDCLASS.



CLASS zrah_git_longest_palindrome IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( find( 'asadaadakjkshkdaksdajhejrqwkrndnasmnamndqkqwemdnasdasd' ) ).
  ENDMETHOD.

  METHOD find.
    DATA(l) = strlen( s ).
    DATA(i) = 0.
    WHILE i < l.
*      DATA(c) = s+i(1).
      DATA(p) = palindrome=>create( s = s c = i ).
      IF p IS BOUND.
        IF Longest_palindorme IS BOUND.
          IF Longest_palindorme->length( ) < p->length( ).
            Longest_palindorme = p.
          ENDIF.
        ELSE.
          Longest_palindorme = p.
        ENDIF.
      ENDIF.
      i = i + 1.
    ENDWHILE.
    IF Longest_palindorme IS BOUND.
      max_s = Longest_palindorme->get( ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.


