CLASS zrah_git_interval_overlap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF lty_interval,
             start TYPE i,
             end   TYPE i,
           END OF lty_interval,
           ltt_interval TYPE STANDARD TABLE OF lty_interval.
    DATA: lt_interval TYPE ltt_interval.

    INTERFACES: if_oo_adt_classrun.

    METHODS:

      overlap_count IMPORTING it_interval     TYPE ltt_interval
                    RETURNING VALUE(rv_count) TYPE i.


  PROTECTED SECTION.

  PRIVATE SECTION.


ENDCLASS.



CLASS zrah_git_interval_overlap IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_input TYPE ltt_interval.

    lt_input = VALUE #( ( start = 1 end = 5 )
                        ( start = 5 end = 7 )
                        ( start = 1 end = 10 ) ).

    out->write(
      EXPORTING
        data   = overlap_count( lt_input )
    ).

  ENDMETHOD.

  METHOD overlap_count.

    DATA(lt_interval) = it_interval[].

    SORT lt_interval BY start.

    LOOP AT lt_interval INTO DATA(lwa_interval).

      " populate previous as the first interval
      IF sy-tabix EQ 1.
        DATA(lwa_previous) = lwa_interval.
        CONTINUE.
      ENDIF.

      " compare current with previous

      IF lwa_previous-end > lwa_interval-start. "overlaps
        IF lwa_previous-start < lwa_interval-start. "full overall
          lwa_previous = lwa_interval.    " update previous to current
          rv_count = rv_count + 1.
        ELSE.                                       "partial overlap
          rv_count = rv_count + 1.                " no change to previous

        ENDIF.
      ELSE.
        lwa_previous = lwa_interval.                " no overlap, update previous.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
