defmodule Keyring.Supervisor do
use Supervisor
require Logger

@registry_name :keyring_registry

def start_link do

Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
end

def start_keyring(key_id) do

Supervisor.start_child(__MODULE__, [ key_id ])
end

def stop_keyring(key_id) do

 case Registry.lookup(@registry_name,  key_id) do

   [] -> :ok
   [{pid, _}] ->
     Process.exit(pid, :shutdown)
     :ok
 end
end

def init(_) do

children = [worker(Keyring, [], restart: :transient)]
supervise(children, [strategy: :simple_one_for_one])
end

def find_or_create_process(key_id)  do

 if process_exists?(key_id) do

   {:ok, key_id}
 else
   key_id |> start_key
 end
end

def process_exists?(key_id)  do

 case Registry.lookup(@registry_name, key_id) do
   [] -> false
   _ -> true
 end
 end

def key_ids do

Supervisor.which_children(__MODULE__)
 |> Enum.map(fn {_, account_proc_pid, _, _} ->
   Registry.keys(@registry_name, account_proc_pid)
     |> List.first
   end)
 |> Enum.sort
end
end