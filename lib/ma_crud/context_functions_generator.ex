defmodule MaCrud.ContextFunctionsGenerator do
  @moduledoc false

  def get_repo_module(opts) do
    quote do
      case Keyword.get(unquote(opts), :repo, nil) do
        nil -> alias!(Repo)
        repo -> repo
      end
    end
  end

  def generate_function(:exists, name, _pluralized_name, module, _opts) do
    quote do
      @doc """
      Lookup #{unquote(name)} based on id
      """
      def unquote(:"#{name}_exists?")(id) do
        import Ecto.Query, only: [from: 2]
        repo = unquote(:"repo_for_#{name}")()

        query = from(x in unquote(module), where: x.id == ^id)

        repo.exists?(query)
      end
    end
  end

  def generate_function(:get, name, _pluralized_name, module, _opts) do
    quote do
      @doc """
      Get the #{unquote(name)} schema by id.

      Args:

        `opts`:
          `assocs`: list of associations to preload
      """
      def unquote(:"get_#{name}")(id, opts \\ []) do
        assocs = opts[:assocs] || []
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> repo.get(id, opts)
        |> repo.preload(assocs)
      end

      @doc """
      Get the #{unquote(name)} schema by a field.

      Args:

        `opts`:
          `assocs`: list of associations to preload
      """
      def unquote(:"get_#{name}_by")(clauses, opts \\ []) do
        assocs = opts[:assocs] || []
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> repo.get_by(clauses, opts)
        |> repo.preload(assocs)
      end

      def unquote(:"get_#{name}!")(id, opts \\ []) do
        assocs = opts[:assocs] || []
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> repo.get!(id, opts)
        |> repo.preload(assocs)
      end

      def unquote(:"get_#{name}_by!")(clauses, opts \\ []) do
        assocs = opts[:assocs] || []
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> repo.get_by!(clauses, opts)
        |> repo.preload(assocs)
      end
    end
  end

  def generate_function(:list, name, pluralized_name, module, _opts) do
    quote do
      def unquote(:"list_#{pluralized_name}")(opts \\ [], repo_opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> MaCrud.Query.list(opts)
        |> repo.all(repo_opts)
      end

      def unquote(:"list_#{pluralized_name}_with_assocs")(assocs, opts \\ [], repo_opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> MaCrud.Query.list(opts)
        |> repo.all(repo_opts)
        |> repo.preload(assocs)
      end
    end
  end

  def generate_function(:count, name, pluralized_name, module, _opts) do
    quote do
      def unquote(:"count_#{pluralized_name}")(field \\ :id, repo_opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> repo.aggregate(:count, field, repo_opts)
      end
    end
  end

  def generate_function(:search, name, pluralized_name, module, _opts) do
    quote do
      def unquote(:"search_#{pluralized_name}")(search_term, repo_opts \\ []) do
        module_fields = unquote(module).__schema__(:fields)
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> MaCrud.Query.search(search_term, module_fields)
        |> repo.all(repo_opts)
      end
    end
  end

  def generate_function(:filter, name, pluralized_name, module, _opts) do
    quote do
      def unquote(:"filter_#{pluralized_name}")(filters, repo_opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> MaCrud.Query.filter(filters)
        |> repo.all(repo_opts)
      end
    end
  end

  def generate_function(:create, name, _pluralized_name, module, opts) do
    quote do
      def unquote(:"create_#{name}")(attrs, opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> struct()
        |> unquote(module).unquote(opts[:create])(attrs)
        |> repo.insert(opts)
      end

      def unquote(:"create_#{name}!")(attrs, opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        unquote(module)
        |> struct()
        |> unquote(module).unquote(opts[:create])(attrs)
        |> repo.insert!(opts)
      end
    end
  end

  def generate_function(:update, name, _pluralized_name, module, opts) do
    quote do
      def unquote(:"update_#{name}")(%unquote(module){} = struct, attrs, repo_opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        struct
        |> unquote(module).unquote(opts[:update])(attrs)
        |> repo.update(repo_opts)
      end

      def unquote(:"update_#{name}!")(%unquote(module){} = struct, attrs, repo_opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        struct
        |> unquote(module).unquote(opts[:update])(attrs)
        |> repo.update!(repo_opts)
      end

      def unquote(:"update_#{name}_with_assocs")(
            %unquote(module){} = struct,
            attrs,
            assocs,
            repo_opts \\ []
          ) do
        repo = unquote(:"repo_for_#{name}")()

        struct
        |> repo.preload(assocs)
        |> unquote(module).unquote(opts[:update])(attrs)
        |> repo.update(repo_opts)
      end

      def unquote(:"update_#{name}_with_assocs!")(
            %unquote(module){} = struct,
            attrs,
            assocs,
            repo_opts \\ []
          ) do
        repo = unquote(:"repo_for_#{name}")()

        struct
        |> repo.preload(assocs)
        |> unquote(module).unquote(opts[:update])(attrs)
        |> repo.update!(repo_opts)
      end
    end
  end

  def generate_function(:delete, name, _pluralized_name, module, opts) do
    quote do
      def unquote(:"delete_#{name}")(%unquote(module){} = struct, repo_opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        struct
        |> Ecto.Changeset.change()
        |> check_assocs(unquote(opts[:check_constraints_on_delete]))
        |> repo.delete(repo_opts)
      end

      def unquote(:"delete_#{name}!")(%unquote(module){} = struct, repo_opts \\ []) do
        repo = unquote(:"repo_for_#{name}")()

        struct
        |> Ecto.Changeset.change()
        |> check_assocs(unquote(opts[:check_constraints_on_delete]))
        |> repo.delete!(repo_opts)
      end
    end
  end

  def generate_function(:check_assocs, _, _, _, _) do
    quote do
      defp unquote(:check_assocs)(changeset, constraints) when is_list(constraints) do
        Enum.reduce(constraints, changeset, fn i, acc ->
          Ecto.Changeset.no_assoc_constraint(acc, i)
        end)
      end
    end
  end

  def generate_function(:get_repo, name, _pluralized_name, _module, opts) do
    quote do
      defp unquote(:"repo_for_#{name}")() do
        unquote(get_repo_module(opts))
      end
    end
  end

  def generate_function(:change, name, _pluralized_name, module, opts) do
    quote do
      def unquote(:"change_#{name}")(%unquote(module){} = struct, attrs \\ %{}) do
        struct
        |> unquote(module).unquote(opts[:create])(attrs)
      end
    end
  end
end
