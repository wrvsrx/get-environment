{
  leanPackages,
}:
leanPackages.buildLakePackage {
  pname = "get-environment";
  version = "0.1.0";
  src = builtins.path { path = ./.; };
}
