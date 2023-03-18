defmodule UsersContext do
  require MaCrud.Context
  alias Example.Like
  alias Example.User
  alias Example.Post
  alias Example.Repo

  MaCrud.Context.generate_functions(User, check_constraints_on_delete: [:posts, :likes])
  MaCrud.Context.generate_functions(Post)
  MaCrud.Context.generate_functions(Like)
end
