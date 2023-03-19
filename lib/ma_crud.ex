defmodule MaCrud do
  @moduledoc """
  Documentation for `MaCrud`.
  """

  defmacro __using__(_) do
    quote do
      require MaCrud
    end
  end

  defmacro generate(schema, opts \\ []) do
    quote do
      require MaCrud.Context
      MaCrud.Context.generate_functions(unquote(schema), unquote(opts))
    end
  end

  @doc """
  ## Examples

      iex> MaCrud.default create: :create_changeset, update: :update_changeset
      :ok

      iex> MaCrud.default only: [:create, :list]
      :ok

      iex> MaCrud.default except: [:get!, :list, :delete]
      :ok
  """

  defmacro default(opts) do
    quote do
      require MaCrud.Context
      MaCrud.Context.default(unquote(opts))
    end
  end
end
