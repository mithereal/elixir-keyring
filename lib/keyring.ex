defmodule Keyring do

@moduledoc "A Keyring Module to Store Your API Keys."

alias Keyring.Supervisor, as: Sup
alias Keyring.Server, as: Server

@doc """
Start the keyring server.
## Examples
    iex> Keyring.start("google")
    ":ok"
"""
def start(name)  do

  pid = Sup.start(name)

    { :ok, pid }
  end

@doc """
Stop the keyring server.
## Examples
    iex> Keyring.stop("google")
    ":ok"
"""
def stop(name)  do

  pid = Sup.stop(name)

    { :ok, pid }
  end

@doc """
Add a key to the keyring server.
## Examples
    iex> Keyring.add("google", %{key: 'google_location_api', value: 'value'})
    ":ok"
"""
def add(name, data)  do

  data = Server.add(name, data)

    { :ok, data }
  end

@doc """
Pop a key to the keyring server.
## Examples
    iex> Keyring.pop(google", %{key: 'google_location_api', value: 'value'})
    "%{key: 'google_location_api', value: 'value'}"
"""
def pop(name, data)  do

  data = Server.pop(name, data)

    { :ok, data }
  end

@doc """
Pop a key to the keyring server.
## Examples
    iex> Keyring.update("google", %{key: 'google_location_api', value: 'value'})
    "[keys]"
"""
def update(name, data)  do

  data = Server.update(name, data)

    { :ok, data }
  end

@doc """
Delete the key/value pair.
## Examples
    iex> Keyring.delete("google", %{key: 'google_location_api', value: 'value'})
    "[keys]"
"""
def delete(name, data)  do

  data = Server.update(name, data)

    { :ok, data }
  end


end