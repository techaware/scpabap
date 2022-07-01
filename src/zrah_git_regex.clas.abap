CLASS zrah_git_regex DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES:
  if_oo_adt_classrun.

  methods:
  regex importing s type string
                  p type string
        RETURNING VALUE(match) type xsdboolean.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrah_git_regex IMPLEMENTATION.

  METHOD regex.

    if p is initial and s is initial.
        match = abap_true.
        return.
    endif.

    if s is not initial.
        data(first_match) = xsdbool( s(1) = p(1) or p(1) = '.' ).
    endif.

    data(s1) = s+1.
    data(p1) = p+1.

    if strlen( p ) >= 2 and p+1(1) = '*'.
        data(p2) = p+2.
        match = xsdbool( regex( s = s p = p2 ) OR ( first_match is not initial and regex( s = s1 p = p ) ) ).
    else.
        match = xsdbool( first_match is not initial  and regex( s = s1 p = p1 ) ).
    endif.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    out->write( regex( s = 'aaab' p = 'a*bk' ) ).

  ENDMETHOD.

ENDCLASS.
