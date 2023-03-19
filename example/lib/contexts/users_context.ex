defmodule UsersContext do
  use MaCrud
  alias Example.Like
  alias Example.User
  alias Example.Post
  alias Example.Repo

  MaCrud.generate(User, check_constraints_on_delete: [:posts, :likes])
  MaCrud.generate(Post)
  MaCrud.generate(Like)
end
