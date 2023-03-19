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

