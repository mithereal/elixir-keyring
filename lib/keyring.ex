defmodule Keyring do

require Logger

use GenServer

  @moduledoc """
  Documentation for Keyring.
  """

defstruct keys: [],

  @doc """
  put a key in the store.

  ## Examples

      iex> Keyring.put(key,value)


  """
  def put(key,value) do
    nil
  end

  @doc """
  fetch a key from the store.

  ## Examples

      iex> Keyring.put(key)


  """
  def get(key) do
    nil
  end
end
