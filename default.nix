{
  leanPackages,
}:
leanPackages.buildLakePackage {
  pname = "get-environment";
  version = "0.2.0";
  src = builtins.path { path = ./.; };
}
