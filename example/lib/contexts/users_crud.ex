defmodule UsersCrud do
  # https://elixirforum.com/t/prototyping-and-enforcing-context-function-conventions/38821/2
  # trying https://gist.github.com/baldwindavid/7da385f0e79cbee62331d5be0b8c75db

  alias Example.User
  alias Example.Repo
  alias Example.Crud
  require Example.Crud
  import Ecto.Query

  @resource Crud.config(User, Repo)

  # Common CRUD functions
  Crud.list(@resource)
  Crud.get!(@resource)
  Crud.get(@resource)
  Crud.new(@resource)
  Crud.create(@resource, &User.changeset/2)
  Crud.change(@resource, &User.changeset/2)
  Crud.update(@resource, &User.changeset/2)
  Crud.delete(@resource)

  # CRUD helpers
  Crud.paginate(@resource)
  Crud.get_for!(@resource, :company)
  # Crud.get_for(@resource, :company)
  Crud.get_by_attr!(@resource, :username)
  Crud.get_by_attr(@resource, :username)
  Crud.preload(@resource, :posts)
  Crud.join(@resource, :company)
  # Crud.filter_by_one(@resource, :property)
  # Crud.filter_by_one_or_many(@resource, :unit_type)
  Crud.order_by(@resource, :username, :desc)
end
