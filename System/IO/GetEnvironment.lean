@[extern "c_get_environ_raw"]
private opaque getEnvironRaw : IO (Array String)

def getEnvironment : IO (Array (String × String)) := do
  let raw ← getEnvironRaw
  return raw.filterMap fun entry =>
    match entry.splitOn "=" with
    | key :: rest => some (key, "=".intercalate rest)
    | _           => none
