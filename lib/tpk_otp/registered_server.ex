defmodule TPK.Common.OTP.RegisteredServer do
  @moduledoc """
  Defines a GenServer which can be addressed by a name instead a pid. 
  By using the module we will inject you a `start_link/1` function and another
  function `reg_name/1`. 

  First make sure you have a `Registry` up and running. Usually, in a `Phoenix` or `Elixir`
  application you will do that in `Application` and start the Registry as a supervised 
  child, like so 

  `application.ex`
      ...
      def start(_type, _args) do
        children =
          [
            ...,
            {Registry,keys: :unique, name: MyRegistry}
          ] 
      ...

  Then define your own GenServer but use `use RegisteredServer` instead of `use GenServer` 
  directely. When using RegisteredServer, provide two arguments. The module you're about
  to define and the registry to use.

  When calling `start_link/1` you have to provide `reg_name` as an argument for the unique 
  process name to be registered, followed by whatever keys your server needs.

      {:ok, _unused_pid} = ServerTest.start_link(reg_name: "Server-1", my_key: :something)

  ### Example

  For your server you have to implement the `init/1` function but not `start_link/1`. 
  `start_link/1` will be defined by `use RegisteredServer` implicitly.

      defmodule ServerTest do
        use RegisteredServer, module: __MODULE__, registry: MyRegistry

        @impl true
        def init(args) do
          {:ok, args}
        end

        def myfunc(server) do
          GenServer.call(process_name(server), :mystate)
        end

        @impl true
        def handle_call(:mystate, _, state), do: {:reply, state[:mystate], state}
      end

  ### Usage

      {:ok, _s1} = ServerTest.start_link(reg_name: "Server-1", mystate: :foo)
      {:ok, _s2} = ServerTest.start_link(reg_name: "Server-2", mystate: :bar)
      {:error, {:already_started, _pid}} = ServerTest.start_link(reg_name: "Server-2")

      assert ServerTest.reg_name("Server-1") == "Server-1"
      assert ServerTest.myfunc("Server-1") == :foo

      assert ServerTest.reg_name("Server-2") == "Server-2"
      assert ServerTest.myfunc("Server-2") == :bar


  """

  defmacro __using__(opts) do
    quote do
      use GenServer

      def start_link(args) do
        GenServer.start_link(unquote(opts[:module]), args, name: process_name(args[:reg_name]))
      end

      @doc """
      Return the registered name for this server. 
      Which is the argument `:reg_name` passed in `start_link/1`.
      """
      def server_name(name) do
        GenServer.call(process_name(name), :reg_name)
      end

      @impl true
      def handle_call(:reg_name, _, state) do
        {:reply, state[:reg_name], state}
      end

      defp process_name(name) do
        {:via, Registry, {unquote(opts[:registry]), name}}
      end
    end
  end
end
