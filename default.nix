{
  leanPackages,
  glfw,
}:
leanPackages.buildLakePackage {
  pname = "get-environment";
  version = "0.0.0";
  src = builtins.path { path = ./.; };
  nativeBuildInputs = [ glfw ];
}
