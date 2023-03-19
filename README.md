# MaCrud

Hard fork from https://github.com/jungsoft/crudry/ without dependency on Absinthe.


# Usage

```elixir
defmodule MyApp.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field(:content, :string)
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content])
  end
end

defmodule MyApp.Comments do
  use MaCrud
  MaCrud.generate(MyApp.Comment, repo: MyApp.Repo)
end

iex> IO.inspect(MyApp.Comments.__info__(:functions))
[
  change_comment: 1,
  change_comment: 2,
  comment_exists?: 1,
  count_comments: 0,
  count_comments: 1,
  count_comments: 2,
  create_comment: 1,
  create_comment: 2,
  create_comment!: 1,
  create_comment!: 2,
  delete_comment: 1,
  delete_comment: 2,
  delete_comment!: 1,
  delete_comment!: 2,
  filter_comments: 1,
  filter_comments: 2,
  get_comment: 1,
  get_comment: 2,
  get_comment!: 1,
  get_comment!: 2,
  get_comment_by: 1,
  get_comment_by: 2,
  get_comment_by!: 1,
  get_comment_by!: 2,
  list_comments: 0,
  list_comments: 1,
  list_comments: 2,
  list_comments_with_assocs: 1,
  list_comments_with_assocs: 2,
  list_comments_with_assocs: 3,
  search_comments: 1,
  search_comments: 2,
  update_comment: 2,
  update_comment: 3,
  update_comment!: 2,
  update_comment!: 3,
  update_comment_with_assocs: 3,
  update_comment_with_assocs: 4,
  update_comment_with_assocs!: 3,
  update_comment_with_assocs!: 4
]
```

## Generated code

```elixir
defmodule CommentsContext do
  def unquote(:update_comment_with_assocs!)(%Example.Comment{} = struct, attrs, assocs, repo_opts) do
    repo = repo_for_comment()
    repo.update!(Example.Comment.changeset(repo.preload(struct, assocs), attrs), repo_opts)
  end

  def unquote(:update_comment_with_assocs!)(x0, x1, x2) do
    super(x0, x1, x2, [])
  end

  def update_comment_with_assocs(%Example.Comment{} = struct, attrs, assocs, repo_opts) do
    repo = repo_for_comment()
    repo.update(Example.Comment.changeset(repo.preload(struct, assocs), attrs), repo_opts)
  end

  def update_comment_with_assocs(x0, x1, x2) do
    super(x0, x1, x2, [])
  end

  def unquote(:update_comment!)(%Example.Comment{} = struct, attrs, repo_opts) do
    repo = repo_for_comment()
    repo.update!(Example.Comment.changeset(struct, attrs), repo_opts)
  end

  def unquote(:update_comment!)(x0, x1) do
    super(x0, x1, [])
  end

  def update_comment(%Example.Comment{} = struct, attrs, repo_opts) do
    repo = repo_for_comment()
    repo.update(Example.Comment.changeset(struct, attrs), repo_opts)
  end

  def update_comment(x0, x1) do
    super(x0, x1, [])
  end

  def search_comments(search_term, repo_opts) do
    module_fields = Example.Comment.__schema__(:fields)
    repo = repo_for_comment()
    repo.all(MaCrud.Query.search(Example.Comment, search_term, module_fields), repo_opts)
  end

  def search_comments(x0) do
    super(x0, [])
  end

  defp repo_for_comment() do
    case Keyword.get(
           [
             create: :changeset,
             update: :changeset,
             only: [],
             except: [],
             check_constraints_on_delete: [],
             repo: Example.Repo
           ],
           :repo,
           nil
         ) do
      nil -> Repo
      repo -> repo
    end
  end

  def list_comments_with_assocs(assocs, opts, repo_opts) do
    repo = repo_for_comment()
    repo.preload(repo.all(MaCrud.Query.list(Example.Comment, opts), repo_opts), assocs)
  end

  def list_comments_with_assocs(x0, x1) do
    super(x0, x1, [])
  end

  def list_comments_with_assocs(x0) do
    super(x0, [], [])
  end

  def list_comments(opts, repo_opts) do
    repo = repo_for_comment()
    repo.all(MaCrud.Query.list(Example.Comment, opts), repo_opts)
  end

  def list_comments(x0) do
    super(x0, [])
  end

  def list_comments() do
    super([], [])
  end

  def unquote(:get_comment_by!)(clauses, opts) do
    assocs =
      case opts[:assocs] do
        x when :erlang.orelse(:erlang."=:="(x, false), :erlang."=:="(x, nil)) -> []
        x -> x
      end

    repo = repo_for_comment()
    repo.preload(repo.get_by!(Example.Comment, clauses, opts), assocs)
  end

  def unquote(:get_comment_by!)(x0) do
    super(x0, [])
  end

  def get_comment_by(clauses, opts) do
    assocs =
      case opts[:assocs] do
        x when :erlang.orelse(:erlang."=:="(x, false), :erlang."=:="(x, nil)) -> []
        x -> x
      end

    repo = repo_for_comment()
    repo.preload(repo.get_by(Example.Comment, clauses, opts), assocs)
  end

  def get_comment_by(x0) do
    super(x0, [])
  end

  def unquote(:get_comment!)(id, opts) do
    assocs =
      case opts[:assocs] do
        x when :erlang.orelse(:erlang."=:="(x, false), :erlang."=:="(x, nil)) -> []
        x -> x
      end

    repo = repo_for_comment()
    repo.preload(repo.get!(Example.Comment, id, opts), assocs)
  end

  def unquote(:get_comment!)(x0) do
    super(x0, [])
  end

  def get_comment(id, opts) do
    assocs =
      case opts[:assocs] do
        x when :erlang.orelse(:erlang."=:="(x, false), :erlang."=:="(x, nil)) -> []
        x -> x
      end

    repo = repo_for_comment()
    repo.preload(repo.get(Example.Comment, id, opts), assocs)
  end

  def get_comment(x0) do
    super(x0, [])
  end

  def filter_comments(filters, repo_opts) do
    repo = repo_for_comment()
    repo.all(MaCrud.Query.filter(Example.Comment, filters), repo_opts)
  end

  def filter_comments(x0) do
    super(x0, [])
  end

  def unquote(:delete_comment!)(%Example.Comment{} = struct, repo_opts) do
    repo = repo_for_comment()
    repo.delete!(check_assocs(Ecto.Changeset.change(struct), []), repo_opts)
  end

  def unquote(:delete_comment!)(x0) do
    super(x0, [])
  end

  def delete_comment(%Example.Comment{} = struct, repo_opts) do
    repo = repo_for_comment()
    repo.delete(check_assocs(Ecto.Changeset.change(struct), []), repo_opts)
  end

  def delete_comment(x0) do
    super(x0, [])
  end

  def unquote(:create_comment!)(attrs, opts) do
    repo = repo_for_comment()
    repo.insert!(Example.Comment.changeset(Kernel.struct(Example.Comment), attrs), opts)
  end

  def unquote(:create_comment!)(x0) do
    super(x0, [])
  end

  def create_comment(attrs, opts) do
    repo = repo_for_comment()
    repo.insert(Example.Comment.changeset(Kernel.struct(Example.Comment), attrs), opts)
  end

  def create_comment(x0) do
    super(x0, [])
  end

  def count_comments(field, repo_opts) do
    repo = repo_for_comment()
    repo.aggregate(Example.Comment, :count, field, repo_opts)
  end

  def count_comments(x0) do
    super(x0, [])
  end

  def count_comments() do
    super(:id, [])
  end

  def unquote(:comment_exists?)(id) do
    Ecto.Query
    repo = repo_for_comment()

    query = %{
      __struct__: Ecto.Query,
      aliases: %{},
      assocs: [],
      combinations: [],
      distinct: nil,
      from: %Ecto.Query.FromExpr{
        source: {Example.Comment.__schema__(:source), Example.Comment},
        params: [],
        as: nil,
        prefix: Example.Comment.__schema__(:prefix),
        hints: []
      },
      group_bys: [],
      havings: [],
      joins: [],
      limit: nil,
      lock: nil,
      offset: nil,
      order_bys: [],
      prefix: nil,
      preloads: [],
      select: nil,
      sources: nil,
      updates: [],
      wheres: [
        %Ecto.Query.BooleanExpr{
          expr: {:==, [], [{{:., [], [{:&, [], [0]}, :id]}, [], []}, {:^, [], [0]}]},
          op: :and,
          params: [{Ecto.Query.Builder.not_nil!(id), {0, :id}}],
          subqueries: []
        }
      ],
      windows: [],
      with_ctes: nil
    }

    repo.exists?(query)
  end

  defp check_assocs(changeset, constraints) do
    Enum.reduce(constraints, changeset, fn i, acc ->
      Ecto.Changeset.no_assoc_constraint(acc, i)
    end)
  end

  def change_comment(%Example.Comment{} = struct, attrs) do
    Example.Comment.changeset(struct, attrs)
  end

  def change_comment(x0) do
    super(x0, %{})
  end
end
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ma_crud` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ma_crud, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ma_crud>.

