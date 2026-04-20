-- Pure FFI: maps to `c_add(uint32_t, uint32_t)` in native.c
@[extern "c_add"]
opaque cAdd (a b : UInt32) : UInt32

-- IO FFI: maps to `c_greet(lean_obj_arg, lean_obj_arg)` in native.c
@[extern "c_greet"]
opaque cGreet (name : String) : IO Unit

def main : IO Unit := do
  let sum := cAdd 21 21
  IO.println s!"cAdd 21 21 = {sum}"
  cGreet "World"
