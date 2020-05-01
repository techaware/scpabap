CLASS zrah_git_meeting_rooms DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_meeting,
             s TYPE i, " start time
             e TYPE i, " end time
           END OF ty_meeting,
           tt_meeting TYPE STANDARD TABLE OF ty_meeting with default key.

    INTERFACES: if_oo_adt_classrun.
    METHODS:
      calc_rooms IMPORTING meetings              TYPE tt_meeting
                 RETURNING VALUE(min_room_count) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrah_git_meeting_rooms IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    data(meetings) = value tt_meeting(  ( s = 5  e = 10 )
                                        ( s = 8  e = 12 )
                                        ( s = 9  e = 15 )
                                        ( s = 11 e = 18 )
                                        ( s = 16 e = 20 ) ).

    out->write( |1. Minimum Number of meeting rooms required:{ calc_rooms( meetings ) }| ).

         meetings  = value tt_meeting(  ( s = 0  e = 30 )
                                        ( s = 5  e = 10 )
                                        ( s = 15  e = 20 ) ).

    out->write( |2. Minimum Number of meeting rooms required:{ calc_rooms( meetings ) }| ).

         meetings  = value tt_meeting(  ( s = 7  e = 10 )
                                        ( s = 2  e = 4 ) ).

    out->write( |3. Minimum Number of meeting rooms required:{ calc_rooms( meetings ) }| ).



  ENDMETHOD.

  METHOD calc_rooms.
  data: curr_room_count type i.
* data declarations
    DATA(m) = meetings[].

* add inverted meeting schedule to same table
    LOOP AT meetings ASSIGNING FIELD-SYMBOL(<meeting>).
      APPEND INITIAL LINE TO m ASSIGNING FIELD-SYMBOL(<invert_meeting>).
      <invert_meeting>-s = <meeting>-e.
      <invert_meeting>-e = <meeting>-s.
    ENDLOOP.

* sort the meeting by start time
    SORT m ASCENDING BY s.

* process the meetings

* First meeting will always need one room
    IF m IS NOT INITIAL.
      curr_room_count = 1.
      DATA(prev_m) = m[ 1 ].
    ELSE.
      min_room_count = 0.
      RETURN.
    ENDIF.

    LOOP AT m ASSIGNING FIELD-SYMBOL(<m>) FROM 2.
      IF <m>-e < <m>-s.
*       this is inverted meeting
        curr_room_count = curr_room_count - 1.
      ELSE.
*       this is normal meeting
*       if this meeting starts before previous ends
        IF <m>-s < prev_m-e.
          curr_room_count = curr_room_count + 1.
        else.
*       special case: when all prev meeting ended and new meeting starts
            if curr_room_count = 0.
                curr_room_count = 1.
            endif.
        ENDIF.
        prev_m = <m>.
      ENDIF.

      if min_room_count < curr_room_count.
        min_room_count = curr_room_count.
      endif.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
