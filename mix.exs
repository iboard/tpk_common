defmodule TpkCommon.MixProject do
  use Mix.Project

  def project do
    [
      app: :tpk_common,
      version: "0.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      source_url: "https://github.com/iboard/tpk_common",
      homepage_url: "https://github.com/iboard/tpk",
      docs: docs(),
      package: package()
    ]
  end

  defp docs() do
    [
      main: "readme",
      extras: ["README.md", "LICENSE.md","cheatsheet.cheatmd"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:earmark, "~>1.4"}
    ]
  end

  defp description() do
    ~s"""
    A package with pure function modules, as a summary of "Andi's Attic Library".
    """
  end

  defp package() do
    [
      name: "tpk_common_library",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/iboard/tpk"
      }
    ]
  end
end
