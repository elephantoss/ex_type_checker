defmodule TypeChecker.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :type_checker,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        ensure_consistency: :test
      ],
      # Docs
      name: "Type Checker",
      source_url: "https://github.com/elephantoss/ex_type_checker",
      homepage_url: "https://github.com/elephantoss/ex_type_checker",
      docs: [
        # The main page in the docs
        main: "Type Checker",
        extras: ["README.md"]
      ]
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
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.14.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.28.5", only: :dev, runtime: false},
      {:inch_ex, "~> 2.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.2", only: [:dev, :test], runtime: false}
    ]
  end

  #  package info for publishing to Hex.pm
  defp package do
    [
      files: ~w(lib LICENSE mix.exs README.md),
      name: "type_checker",
      licenses: ["MIT"],
      maintainers: ["elephantoss"],
      links: %{"GitHub" => "https://github.com/elephantoss/ex_type_checker"}
    ]
  end

  defp aliases do
    [
      docs_html: ["docs --formattter html -o doc/ex_doc"],
      ensure_consistency: [
        "test",
        "dialyzer",
        "credo --strict",
        "inch",
        "coveralls"
      ]
    ]
  end
end