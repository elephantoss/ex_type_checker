defmodule TypeChecker do
  @moduledoc """
  TypeChecker provides one function to check the type of variables.

  It is inspired by https://stackoverflow.com/questions/28377135/check-typeof-variable-in-elixir thread.
  """

  @doc """
  `which?/1` returns the type of a variable.

  ## Examples
      iex> TypeChecker.which?(:atom)
      "atom"
      iex> bin = "hello"
      iex> TypeChecker.which?(bin)
      "binary"
      iex> bitstr = <<1::3>>
      iex> TypeChecker.which?(bitstr)
      "bitstring"
      iex> TypeChecker.which?(:true)
      "boolean"
      iex> pi = 3.14159
      iex> TypeChecker.which?(pi)
      "float"
      iex> fun = fn (a, b) -> a + b end
      iex> TypeChecker.which?(fun)
      "function"
      iex> TypeChecker.which?(&TypeChecker.which?/1)
      "function"
      iex> int = 42
      iex> TypeChecker.which?(int)
      "integer"
      iex> list = [1,2,3,4]
      iex> TypeChecker.which?(list)
      "list"
      iex> map = %{:foo => "bar", "hello" => :world}
      iex> TypeChecker.which?(map)
      "map"
      iex> TypeChecker.which?(nil)
      "nil"
      iex> pid = spawn(fn -> 1 + 2 end)
      iex> TypeChecker.which?(pid)
      "pid"
      iex> port = Port.open({:spawn, "cat"}, [:binary])
      iex> TypeChecker.which?(port)
      "port"
      iex> ref = :erlang.make_ref
      iex> TypeChecker.which?(ref)
      "reference"
      iex> tuple = {:name, "alex"}
      iex> TypeChecker.which?(tuple)
      "tuple"
  """
  types =
    ~w[boolean binary bitstring float function integer list struct map nil pid port reference tuple atom]

  for type <- types do
    def which?(x) when unquote(:"is_#{type}")(x), do: unquote(type)
  end

  # No idea how to test this. Do you? ¯\_(ツ)_/¯
  # coveralls-ignore-start
  def which?(_) do
    "unknown"
  end

  # coveralls-ignore-stop
end
