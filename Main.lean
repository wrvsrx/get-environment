import System.IO.GetEnvironment

def main : IO Unit := do
  for (k, v) in (← getEnvironment) do
    IO.println s!"{k}={v}"
