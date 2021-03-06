defmodule Loki.Directory do
  import Loki.Shell


  @moduledoc """
  Working with folders helpers.
  """


  @doc """
  Helper for create directory.
  """
  @spec create_directory(Path.t) :: :ok | {:error, Atom.t}
  def create_directory(path) when is_bitstring(path), do: create_directory(path, [])

  @spec create_directory(Path.t) :: none()
  def create_directory(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec create_directory(Path.t, Keyword.t) :: none()
  def create_directory(path, opts) do
    case File.mkdir_p(path) do
      :ok ->
        say_create("directory " <> path, opts)
        :ok
      {:error, reason} ->
        say_error(reason, opts)
        {:error, reason}
    end
  end


  @doc """
  Helper for checking if file exists.
  """
  @spec exists_directory?(Path.t) :: Boolean.t
  def exists_directory?(path) when is_bitstring(path), do: File.exists?(path)

  @spec exists_directory?(Path.t) :: none()
  def exists_directory?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  Helper for copy directory.
  """
  @spec copy_directory(Path.t, Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def copy_directory(source, target) when is_bitstring(source) and is_bitstring(target) do
    copy_directory(source, target, [])
  end

  @spec copy_directory(any) :: none()
  def copy_directory(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"

  @spec copy_directory(Path.t, Path.t, Keyword.t) :: none()
  def copy_directory(source, target, opts) do
    case File.cp_r(source, target) do
      {:ok, data} ->
        say_copy(source, target, opts)
        {:ok, data}
      {:error, reason, data} ->
        say_error(reason, opts)
        {:error, reason, data}
    end
  end


  @doc """
  Helper for remove directory.
  """
  @spec remove_directory(Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def remove_directory(path) when is_bitstring(path), do: remove_directory(path, [])

  @spec remove_directory(any) :: none()
  def remove_directory(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec remove_directory(Path.t, Keyword.t) :: none()
  def remove_directory(path, opts) do
    case File.rm_rf(path) do
      {:ok, data} ->
        say_remove(path, opts)
        {:ok, data}
      {:error, reason, data} ->
        say_error(reason, opts)
        {:error, reason, data}
    end
  end
end
