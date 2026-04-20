#include <lean/lean.h>
#include <stddef.h>

extern char **environ;

/* Return all environment strings as `IO (Array String)`.
   Each element is a raw "KEY=VALUE" string. */
LEAN_EXPORT lean_obj_res c_get_environ_raw(lean_obj_arg world) {
    size_t n = 0;
    while (environ[n]) n++;

    lean_object *arr = lean_alloc_array(n, n);
    for (size_t i = 0; i < n; i++)
        lean_array_set_core(arr, i, lean_mk_string(environ[i]));

    return lean_io_result_mk_ok(arr);
}
