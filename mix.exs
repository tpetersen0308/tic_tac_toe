defmodule TicTacToe.MixProject do
  use Mix.Project

  def project do
    [
      app: :tic_tac_toe,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: CLI],
      deps: deps(),
      elixirc_paths: compiler_paths(Mix.env())
    ]
  end

  def compiler_paths(:test), do: ["test/helpers"] ++ compiler_paths(:prod)
  def compiler_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 0.8", only: :dev},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end
end
