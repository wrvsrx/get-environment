import Lake
open System Lake DSL

-- TIP: To learn about writing a `lakefile.lean` (or `lakefile.toml`), see
-- https://github.com/leanprover/lean4/blob/master/src/lake/README.md and the
-- directory `examples/` in there.

package GetEnvironment where
  -- add package configuration options here
  version := v!"0.2.0"

target native.o (pkg : NPackage __name__) : FilePath := do
  let native_c := pkg.dir / "System" / "IO" / "native.c"
  let native_o := pkg.staticLibDir / "native.o"

  -- TIP: About 'buildFileAfterDep', see
  -- https://github.com/leanprover/lean4/blob/dfdd682c017a96896d8cfa683f510dd2e0491752/src/lake/Lake/Build/Common.lean#L538.

  -- TIP: About 'inputFile', see
  -- https://github.com/leanprover/lean4/blob/dfdd682c017a96896d8cfa683f510dd2e0491752/src/lake/Lake/Build/Common.lean#L573.

  -- TIP: About 'compileO', see
  -- https://github.com/leanprover/lean4/blob/dfdd682c017a96896d8cfa683f510dd2e0491752/src/lake/Lake/Build/Actions.lean#L79

  buildFileAfterDep native_o (<- inputFile native_c True) fun native_src => do
    let lean_dir := (<- getLeanIncludeDir).toString
    compileO native_o native_src #["-I", lean_dir, "-fPIC"]

extern_lib native (pkg : NPackage __name__) := do
  let name := nameToStaticLib "native"
  let native_o <- fetch <| pkg.target ``native.o
  buildStaticLib (pkg.buildDir / "lib" / name) #[native_o]

lean_lib «GetEnvironment» where
  roots := #[`System.IO.GetEnvironment]
  needs := #[native]

@[default_target]
lean_exe «get_environemnt_exe» where
  root := `Main
  needs := #[«GetEnvironment»]
