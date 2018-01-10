defmodule Keyring.Mixfile do
  use Mix.Project

 @version "0.1.2"

  def project do
    [
      app: :keyring,
      version: @version,
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      name: "Elixir Keyring",
      source_url: "https://github.com/mithereal/elixir-keyring",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Keyring.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end


  defp description() do
    """
   This will hold your api keys.
    """
  end

  defp package() do
    [maintainers: ["Jason Clark"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/mithereal/elixir-keyring"}]
  end

  defp aliases do
        [c: "compile"]
  end

end



