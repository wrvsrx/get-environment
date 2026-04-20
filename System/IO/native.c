#include <lean/lean.h>
#include <stddef.h>
#include <string.h>

extern char **environ;

/*
 * Pure function (no IO world token): reads the process environ and returns
 * a Lean `Array (String × String)`.
 *
 * Each "KEY=VALUE" entry is split on the first '='.
 * lean_mk_string_from_bytes(ptr, len) allocates a Lean string from a byte range.
 * Prod.mk is ctor 0 with 2 object fields and 0 scalar bytes.
 */
LEAN_EXPORT lean_obj_res c_get_environment(void) {
    size_t n = 0;
    while (environ[n]) n++;

    lean_object *arr = lean_alloc_array(n, n);
    for (size_t i = 0; i < n; i++) {
        const char *entry = environ[i];
        const char *eq    = strchr(entry, '=');

        lean_object *key, *val;
        if (eq) {
            key = lean_mk_string_from_bytes(entry, (size_t)(eq - entry));
            val = lean_mk_string(eq + 1);
        } else {
            key = lean_mk_string(entry);
            val = lean_mk_string("");
        }

        lean_object *pair = lean_alloc_ctor(0, 2, 0);
        lean_ctor_set(pair, 0, key);
        lean_ctor_set(pair, 1, val);

        lean_array_set_core(arr, i, pair);
    }
    return arr;
}
