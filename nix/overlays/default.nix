self: super: {
  elixir-ls = with super; callPackage ./elixir-ls {
    inherit elixir erlang git cacert;
  };
}
