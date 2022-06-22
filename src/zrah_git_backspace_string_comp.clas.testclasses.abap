*"* use this source file for your ABAP unit test classes
class zrah_test DEFINITION FOR TESTING Risk Level Harmless Duration Short.
PUBLIC SECTION.
methods:
    test_null FOR TESTING,
    test_hashes for testing,
    test_equal for testing,
    test_notequal for testing,
    test_null_effective for testing.
endclass.

class zrah_test IMPLEMENTATION.
METHOD test_null.

    data(cut) = new zrah_git_backspace_string_comp( ).

    cut->compare(
      EXPORTING
        a     = ''
        b     = ''
      RECEIVING
        equal = data(lv_equal)
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_equal
        exp                  = abap_true
    ).

ENDMETHOD.

  METHOD test_hashes.

    data(cut) = new zrah_git_backspace_string_comp( ).

    cut->compare(
      EXPORTING
        a     = '##########'
        b     = '####'
      RECEIVING
        equal = data(lv_equal)
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_equal
        exp                  = abap_true
    ).

  ENDMETHOD.

  METHOD test_equal.
    data(cut) = new zrah_git_backspace_string_comp( ).

    cut->compare(
      EXPORTING
        a     = 'a#b'
        b     = 'b'
      RECEIVING
        equal = data(lv_equal)
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_equal
        exp                  = abap_true
    ).
  ENDMETHOD.

  METHOD test_notequal.
    data(cut) = new zrah_git_backspace_string_comp( ).

    cut->compare(
      EXPORTING
        a     = 'a#b'
        b     = 'a'
      RECEIVING
        equal = data(lv_equal)
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_equal
        exp                  = abap_false
    ).
  ENDMETHOD.

  METHOD test_null_effective.
    data(cut) = new zrah_git_backspace_string_comp( ).

    cut->compare(
      EXPORTING
        a     = 'a#balds#asda#################'
        b     = '#############asd#asds#####sds#sds################'
      RECEIVING
        equal = data(lv_equal)
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_equal
        exp                  = abap_true
    ).
  ENDMETHOD.

endclass.
