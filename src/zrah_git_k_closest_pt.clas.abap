CLASS zrah_git_k_closest_pt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  types: begin of lty_pts,
          x type i,
          y type i,
         end of LTY_PTS,
         tty_pts type table of lty_pts.

  INTERFACES: if_oo_adt_classrun.
  METHODS:
  get_k_closest_pts IMPORTING k type i
                    pts type tty_pts
                    EXPORTING closest type tty_pts.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrah_git_k_closest_pt IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    get_k_closest_pts( EXPORTING k = 3
                                 pts = value #( ( x = 11 y = 11 )
                                                ( x = -1 y = 21 )
                                                ( x = 13 y = -21 )
                                                ( x = 32 y = -31 )
                                                ( x = 9 y = 9 ) )
                        IMPORTING closest = data(closest) ).
    out->write( closest ).
  ENDMETHOD.

  METHOD get_k_closest_pts.
*   calculate distance from [0,0]
    types: begin of lty_dist,
            x type i,
            y type i,
            d type f,
           end of lty_dist,
*           tty_dist type SORTED TABLE OF lty_dist with NON-UNIQUE key d.
           tty_dist type STANDARD TABLE of lty_dist.
    data: t_dist type tty_dist.

    loop at pts ASSIGNING FIELD-SYMBOL(<fs_pts>).
        APPEND INITIAL LINE TO t_dist ASSIGNING FIELD-SYMBOL(<fs_dist>).
        if sy-subrc eq 0.
            <fs_dist>-x = <fs_pts>-x.
            <fs_dist>-y = <fs_pts>-y.
            <fs_dist>-d = sqrt( ( <fs_pts>-x * <fs_pts>-x ) + ( <fs_pts>-y * <fs_pts>-y ) ).
        endif.
    ENDLOOP.

    sort t_dist by d ASCENDING.

*   return first k rows of t_dist
    loop at t_dist ASSIGNING <fs_dist> from 1 to k.
        append INITIAL LINE TO closest ASSIGNING FIELD-SYMBOL(<fs_closest>).
        if sy-subrc eq 0.
            <fs_closest>-x = <fs_dist>-x.
            <fs_closest>-y = <fs_dist>-y.
        endif.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
