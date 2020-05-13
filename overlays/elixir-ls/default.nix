{ stdenv, elixir, erlang, git, cacert }:

# From https://discourse.nixos.org/t/question-about-packaging-elixirls/4056

stdenv.mkDerivation rec {
  name = "elixir-ls-${version}";

  version = "0.2.26";

  src = builtins.fetchGit {
    url = https://github.com/elixir-lsp/elixir-ls;
    rev = "ba1c9cb86545298c487cf77a166c203fc44ce8dd";
  };

  buildInputs = [ elixir erlang git cacert ];

  buildPhase = ''
    mkdir -p $PWD/.hex
    export HOME=$PWD/.hex

    mix local.hex --force
    mix local.rebar --force

    mix deps.get
    mix compile
  '';

  installPhase = ''
    mkdir -p $out/bin

    mix elixir_ls.release --destination $out/bin
  '';
}
