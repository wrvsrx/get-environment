{
  leanPackages,
}:
leanPackages.buildLakePackage {
  pname = "get-environment";
  version = "0.3.0-dev";
  src = builtins.path { path = ./.; };
}
