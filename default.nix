{ lib
, pkgs
, poetry2nix
, python3
, python3Packages
, projectDir ? ./.
, pyproject ? projectDir + "/pyproject.toml"
, poetrylock ? projectDir + "/poetry.lock"
}:

let
  python = python3;
in {
  app = poetry2nix.mkPoetryApplication {
    inherit python;
    inherit projectDir pyproject poetrylock;

    doCheck = false;

    meta = with lib; {
      inherit (python.meta) platforms;

      homepage = "https://github.com/martiert/training";
      license = licenses.mit;
      description = "server side of training application";

      maintainers = [{
        name = "Martin Ertsås";
        email = "martiert@gmail.com";
      }];
    };
  };

  shell = poetry2nix.mkPoetryEnv {
    inherit python;
    inherit projectDir pyproject poetrylock;

    preferWheels = true;
  };

}
