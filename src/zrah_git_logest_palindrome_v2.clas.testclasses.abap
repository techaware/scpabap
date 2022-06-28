*"* use this source file for your ABAP unit test classes
class lcl_test DEFINITION for testing Risk Level Harmless Duration Short.
public section.
methods:
    test_positive for testing,
    test_single_char for testing,
    test_simple_pal for testing,
    test_start_pal for testing,
    test_end_pal for testing,
    test_middle_pal for testing,
    test_equal_pal for testing,
    test_no_pal for testing.
data:
        go_cut type ref to zrah_git_logest_palindrome_v2.

private section.
methods:
setup,
teardown.

ENDCLASS.

class lcl_test implementation.

method test_positive.

    data(lv_pal) = go_cut->find( '21ABA1X2X1ABA12' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_pal
        exp                  = '21ABA1X2X1ABA12' ).

endmethod.

  method test_end_pal.

    data(lv_pal) = go_cut->find( '12345ABA' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_pal
        exp                  = 'ABA' ).
  endmethod.

  method test_equal_pal.

    data(lv_pal) = go_cut->find( '123ABA456ABA89' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_pal
        exp                  = 'ABA' ).
  endmethod.

  method test_middle_pal.

    data(lv_pal) = go_cut->find( 'ZZABA1X2X1ABAYY' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_pal
        exp                  = 'ABA1X2X1ABA' ).
  endmethod.

  method test_no_pal.

    data(lv_pal) = go_cut->find( '123456789' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_pal
        exp                  = '1' ).
  endmethod.

  method test_simple_pal.

    data(lv_pal) = go_cut->find( 'ABA' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_pal
        exp                  = 'ABA' ).
  endmethod.

  method test_single_char.

    data(lv_pal) = go_cut->find( 'A' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_pal
        exp                  = 'A' ).
  endmethod.

  method test_start_pal.

    data(lv_pal) = go_cut->find( 'ABA12345' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_pal
        exp                  = 'ABA' ).
  endmethod.


  method setup.
    go_cut = new #( ).
  endmethod.

  method teardown.
    lcl_fold=>delete_instance( ).
  endmethod.

endclass.
