defmodule TypeCheckerTest do
  @moduledoc false
  use ExUnit.Case
  doctest TypeChecker

  defstruct [:foo, :bar]

  describe "which?/1" do
    test "returns \"atom\" for an :atom" do
      assert TypeChecker.which?(:atom) == "atom"
    end

    #  recap: https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html
    test "returns \"binary\" when variable is a binary" do
      string = "hello"
      assert TypeChecker.which?(string) == "binary"
    end

    # recap: https://elixir-lang.readthedocs.io/en/latest/intro/6.html#binaries-and-bitstrings
    test "returns \"bitstring\" when variable is a bitstring" do
      bitstr = <<1::size(1)>>
      assert TypeChecker.which?(bitstr) == "bitstring"
    end

    # "Every binary is a bitstring but every bitstring need not be a binary" ...

    test "returns \"float\" if the value is float" do
      golden = 1.618
      assert TypeChecker.which?(golden) == "float"
    end

    test "returns \"function\" when the variable is a function" do
      sum = fn a, b -> a + b end
      assert sum.(2, 3) == 5
      assert TypeChecker.which?(sum) == "function"

      assert TypeChecker.which?(&TypeChecker.which?/1) == "function"
    end

    test "list" do
      list = [1, 2, 3, 4]
      assert TypeChecker.which?(list) == "list"
    end

    test "map" do
      map = %{:foo => "bar", "hello" => :world}
      assert TypeChecker.which?(map) == "map"
    end

    test "nil" do
      assert TypeChecker.which?(nil) == "nil"
    end

    test "pid" do
      pid = spawn(fn -> 1 + 2 end)
      assert TypeChecker.which?(pid) == "pid"
    end

    # https://hexdocs.pm/elixir/1.12/Port.html
    test "port" do
      port = Port.open({:spawn, "cat"}, [:binary])
      assert TypeChecker.which?(port) == "port"
    end

    test "reference" do
      ref = :erlang.make_ref()
      assert TypeChecker.which?(ref) == "reference"
    end

    test "tuple" do
      tuple = {:name, "alex"}
      assert TypeChecker.which?(tuple) == "tuple"
    end

    test "integer" do
      int = 10
      assert TypeChecker.which?(int) == "integer"
    end

    test "struct" do
      struct = %TypeCheckerTest{}
      assert TypeChecker.which?(struct) == "struct"
    end

    test "boolean" do
      bool = true
      assert TypeChecker.which?(bool) == "boolean"
    end
  end
end
