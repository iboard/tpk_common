defmodule TpkCommonOTPRegisteredServerTest do
  use ExUnit.Case
  alias TPK.Common.OTP.RegisteredServer

  doctest TPK.Common.OTP.RegisteredServer

  setup _ do
    Registry.start_link(keys: :unique, name: MyRegistry)

    :ok
  end

  defmodule ServerTest do
    use RegisteredServer, module: __MODULE__, registry: MyRegistry

    @impl true
    def init(args) do
      {:ok, args}
    end

    def count(server) do
      GenServer.call(process_name(server), :count)
    end

    @impl true
    def handle_call(:count, _, state), do: {:reply, state[:count], state}
  end

  describe "Module base" do
    test "module exists" do
      assert is_list(ServerTest.__info__(:functions))
      assert {:reg_name, 1} in ServerTest.__info__(:functions)
    end

    test "use RegisteredServer" do
      {:ok, _s1} = ServerTest.start_link(reg_name: "Server-1", count: 0)
      {:ok, _s2} = ServerTest.start_link(reg_name: "Server-2", count: 1)
      {:error, {:already_started, _pid}} = ServerTest.start_link(reg_name: "Server-2")

      assert ServerTest.reg_name("Server-1") == "Server-1"
      assert ServerTest.count("Server-1") == 0
      assert ServerTest.reg_name("Server-2") == "Server-2"
      assert ServerTest.count("Server-2") == 1
    end

    test "Performance with 10,000 registered server" do
      for i <- 1..10_000 do
        {:ok, _} = ServerTest.start_link(reg_name: "Server-#{i}")
      end

      assert ServerTest.reg_name("Server-1000") == "Server-1000"
      assert ServerTest.reg_name("Server-9999") == "Server-9999"
      assert ServerTest.reg_name("Server-10000") == "Server-10000"
    end
  end
end
