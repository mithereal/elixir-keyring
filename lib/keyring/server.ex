defmodule Keyring.Server do

  use GenServer

  require Logger


  @moduledoc "A Simple Keyring to store your api keys."


  @registry_name :keyring_registry
  @name __MODULE__

  defstruct keys: [ ]


  def start_link(id) do

    name = via_tuple(id)

    GenServer.start_link(__MODULE__, [id], name: name)
  end

  defp via_tuple(id) do

    {:via, Registry, {@registry_name, id}}
  end

  @doc """
  Add a key/value pair.
  ## Examples
      iex> Keyring.add("google", %{key: 'google_location_api', value: 'value'})
      "[keys]"
  """
  def add(id, data) do

    GenServer.call(via_tuple(id), { :add, data } )
  end

  @doc """
  Pop the top key/value pair.
  ## Examples
      iex> Keyring.pop("google")
      "%{key: 'google_location_api', value: 'value'}"
  """
  def pop(id, data) do

    GenServer.call(via_tuple(id), { :pop, data } )
  end

  @doc """
  Update key/value pair.
  ## Examples
      iex> Keyring.update("google", %{key: 'google_location_api', value: 'value'})
      "[keys]"
  """
  def update(id, data) do

    GenServer.call(via_tuple(id), { :update, data } )
  end

  @doc """
  Delete the key/value pair.
  ## Examples
      iex> Keyring.delete("google", %{key: 'google_location_api', value: 'value'})
      "[keys]"
  """
  def delete(id, data) do

    GenServer.call(via_tuple(id), { :delete, data } )
  end

  @doc """
  Show all key/value pairs.
  ## Examples
      iex> Keyring.show("google")
      "[keys]"
  """
  def show(id, data) do

    GenServer.call(via_tuple(id), { :show } )
  end

  def handle_call({ :add, data }, _from, %__MODULE__{ keys: keys } = state) do

    updated_data = keys ++ [data]

    updated_state = %__MODULE__{state |  keys: updated_data }

    {:reply, state, updated_state}
  end

  def handle_call({ :pop, data }, _from, %__MODULE__{ keys: keys } = state) do

    [h|t] = data

    updated_data = t

    updated_state = %__MODULE__{ state |  keys: updated_data }

    { :reply, h, updated_state }
  end

  def handle_call({ :update, data }, _from, %__MODULE__{ keys: keys } = state) do

    new_data = Enum.map(keys, fn(x) ->
      case x.key == data.key do
        true -> %{ key: x.key, data: data.data }
        false -> x
      end
    end)

    updated_state = %__MODULE__{state |  keys: new_data }

    { :reply, updated_state, updated_state }
  end

  def handle_call({ :delete, data }, _from, %__MODULE__{ keys: keys } = state) do

    new_data = Enum.filter(keys, fn(x) -> x.key == data.key end)

    updated_state = %__MODULE__{state |  keys: new_data }

    { :reply, updated_state, updated_state }
  end

  def handle_call({ :show }, _from, %__MODULE__{ keys: keys } = state) do

    { :reply, keys, state }
  end


end