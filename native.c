#include <lean/lean.h>
#include <stdint.h>
#include <stdio.h>

/*
 * Pure function: Lean primitive types (UInt32) map directly to C types.
 * No reference counting or IO world token needed.
 */
LEAN_EXPORT uint32_t c_add(uint32_t a, uint32_t b) {
    return a + b;
}

/*
 * IO action: receives the IO world token as the last argument.
 * lean_string_cstr() extracts the raw C string; lean_dec() releases the ref.
 * lean_box(0) is the unit value returned as the IO result payload.
 */
LEAN_EXPORT lean_obj_res c_greet(lean_obj_arg name, lean_obj_arg world) {
    const char *str = lean_string_cstr(name);
    printf("Hello, %s! (from C)\n", str);
    lean_dec(name);
    return lean_io_result_mk_ok(lean_box(0));
}
