defmodule MaCrud.Context do
  @moduledoc """
  Generates CRUD functions to DRY Phoenix Contexts.

  * Assumes `Ecto.Repo` is being used as the repository.

  * Uses the Ecto Schema source name to generate the pluralized name for the functions, and the module name to generate the singular name.

    This follows the same pattern as the [Mix.Tasks.Phx.Gen.Context](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Context.html), so it should be straightforward to replace Phoenix's auto-generated functions with MaCrud.

  ## Usage

  To generate CRUD functions for a given schema, simply do

      defmodule MyApp.MyContext do
        alias MyApp.Repo
        alias MyApp.MySchema
        require MaCrud.Context

        MaCrud.Context.generate_functions MySchema
      end

  And the context will have all these functions available:

      defmodule MyApp.MyContext do
        alias MyApp.Repo
        alias MyApp.MySchema
        require MaCrud.Context

        ## Exists functions

        def my_schema_exists?(id) do
          import Ecto.Query, only: [from: 2]

          query = from(x in MySchema, where: x.id == ^id)

          Repo.exists?(query)
        end

        ## Get functions

        def get_my_schema(id, opts \\\\ []) do
          assocs = opts[:assoc] || []

          MySchema
          |> Repo.get(id)
          |> Repo.preload(assocs)
        end

        def get_my_schema!(id, opts \\\\ []) do
          assocs = opts[:assoc] || []

          MySchema
          |> Repo.get!(id)
          |> Repo.preload(assocs)
        end

        def get_my_schema_by(clauses, opts \\\\ []) do
          assocs = opts[:assoc] || []

          MySchema
          |> Repo.get_by(clauses)
          |> Repo.preload(assocs)
        end

        def get_my_schema_by!(clauses, opts \\\\ []) do
          assocs = opts[:assoc] || []

          MySchema
          |> Repo.get_by!(clauses)
          |> Repo.preload(assocs)
        end

        ## List functions

        def list_my_schemas() do
          Repo.all(MySchema)
        end

        def list_my_schemas(opts) do
          MySchema
          |> MaCrud.Query.list(opts)
          |> Repo.all()
        end

        def list_my_schemas_with_assocs(assocs) do
          MySchema
          |> Repo.all()
          |> Repo.preload(assocs)
        end

        def list_my_schemas_with_assocs(assocs, opts) do
          MySchema
          |> MaCrud.Query.list(opts)
          |> Repo.all()
          |> Repo.preload(assocs)
        end

        def filter_my_schemas(filters) do
          MySchema
          |> MaCrud.Query.filter(filters)
          |> Repo.all()
        end

        def search_my_schemas(search_term) do
          module_fields = MySchema.__schema__(:fields)

          MySchema
          |> MaCrud.Query.search(search_term, module_fields)
          |> Repo.all()
        end

        def count_my_schemas(field \\\\ :id) do
          Repo.aggregate(MySchema, :count, field)
        end

        ## Create functions

        def create_my_schema(attrs) do
          %MySchema{}
          |> MySchema.changeset(attrs)
          |> Repo.insert()
        end

        def create_my_schema!(attrs) do
          %MySchema{}
          |> MySchema.changeset(attrs)
          |> Repo.insert!()
        end

        ## Update functions

        def update_my_schema(%MySchema{} = my_schema, attrs) do
          my_schema
          |> MySchema.changeset(attrs)
          |> Repo.update()
        end

        def update_my_schema!(%MySchema{} = my_schema, attrs) do
          my_schema
          |> MySchema.changeset(attrs)
          |> Repo.update!()
        end

        def update_my_schema_with_assocs(%MySchema{} = my_schema, attrs, assocs) do
          my_schema
          |> Repo.preload(assocs)
          |> MySchema.changeset(attrs)
          |> Repo.update()
        end

        def update_my_schema_with_assocs!(%MySchema{} = my_schema, attrs, assocs) do
          my_schema
          |> Repo.preload(assocs)
          |> MySchema.changeset(attrs)
          |> Repo.update!()
        end

        ## Delete functions

        def delete_my_schema(%MySchema{} = my_schema) do
          my_schema
          |> Ecto.Changeset.change()
          |> check_assocs([])
          |> Repo.delete()
        end

        def delete_my_schema!(%MySchema{} = my_schema) do
          my_schema
          |> Ecto.Changeset.change()
          |> check_assocs([])
          |> Repo.delete!()
        end

        def change_my_schema(%MySchema{} = my_schema, attrs \\ %{}) do
          my_schema
          |> MySchema.changeset(attrs)
        end

        # Function to check no_assoc_constraints, always generated.
        defp check_assocs(changeset, nil), do: changeset
        defp check_assocs(changeset, constraints) do
          Enum.reduce(constraints, changeset, fn i, acc -> Ecto.Changeset.no_assoc_constraint(acc, i) end)
        end
      end
  """

  @all_functions ~w(exists get list count search filter create update delete change)a
  # Always generate helper functions since they are used in the other generated functions
  @helper_functions ~w(check_assocs)a
  @always_gen_function ~w(get_repo)a

  @doc """
  Sets default options for the context.

  ## Options

    * `:create` - the name of the changeset function used in the `create` function.
    Defaults to `:changeset`.

    * `:update` - the name of the changeset function used in the `update` function.
    Defaults to `:changeset`.

    * `:only` - list of functions to be generated. If not empty, functions not
    specified in this list are not generated. Defaults to `[]`.

    * `:except` - list of functions to not be generated. If not empty, only functions not specified
    in this list will be generated. Defaults to `[]`.

    The accepted values for `:only` and `:except` are: `#{inspect(@all_functions)}`.

  ## Examples

      iex> MaCrud.Context.default create: :create_changeset, update: :update_changeset
      :ok

      iex> MaCrud.Context.default only: [:create, :list]
      :ok

      iex> MaCrud.Context.default except: [:get!, :list, :delete]
      :ok
  """
  defmacro default(opts) do
    Module.put_attribute(__CALLER__.module, :create_changeset, opts[:create])
    Module.put_attribute(__CALLER__.module, :update_changeset, opts[:update])
    Module.put_attribute(__CALLER__.module, :only, opts[:only])
    Module.put_attribute(__CALLER__.module, :except, opts[:except])
    Module.put_attribute(__CALLER__.module, :repo, opts[:repo])
  end

  @doc """
  Generates CRUD functions for the `schema_module`.

  Custom options can be given. To see the available options, refer to the documenation of `MaCrud.Context.default/1`.
  There is also one extra option that cannot be set by default:

    * `check_constraints_on_delete` - list of associations that must be empty to allow deletion.
  `Ecto.Changeset.no_assoc_constraint` will be called for each association before deleting. Defaults to `[]`.

  ## Examples

    Suppose we want to implement basic CRUD functionality for a User schema,
    exposed through an Accounts context:

      defmodule MyApp.Accounts do
        alias MyApp.Repo
        require MaCrud.Context

        # Assuming Accounts.User implements a `changeset/2` function, used both to create and update a user.
        MaCrud.Context.generate_functions Accounts.User
      end

    Now, suppose the changeset for create and update are different, and we want to delete the record only if the association `has_many :assocs` is empty:

      defmodule MyApp.MyContext do
        alias MyApp.Repo
        alias MyApp.MySchema
        require MaCrud.Context

        MaCrud.Context.generate_functions MySchema,
          create: :create_changeset,
          update: :update_changeset,
          check_constraints_on_delete: [:assocs]
      end
  """
  defmacro generate_functions(schema_module, opts \\ []) do
    opts = Keyword.merge(load_default(__CALLER__.module), opts)
    name = MaCrud.Helper.get_underscored_name(schema_module)
    pluralized_name = MaCrud.Helper.get_pluralized_name(schema_module, __CALLER__)

    for func <-
          MaCrud.Helper.get_functions_to_be_generated(
            __CALLER__.module,
            @all_functions,
            @helper_functions,
            @always_gen_function,
            opts
          ) do
      MaCrud.ContextFunctionsGenerator.generate_function(
        func,
        name,
        pluralized_name,
        schema_module,
        opts
      )
    end
  end

  # Load user-defined defaults or fall back to the library's default.
  defp load_default(module) do
    create_changeset = Module.get_attribute(module, :create_changeset)
    update_changeset = Module.get_attribute(module, :update_changeset)
    only = Module.get_attribute(module, :only)
    except = Module.get_attribute(module, :except)
    repo = Module.get_attribute(module, :repo)

    [
      create: create_changeset || :changeset,
      update: update_changeset || :changeset,
      only: only || [],
      except: except || [],
      check_constraints_on_delete: [],
      repo: repo
    ]
  end
end
