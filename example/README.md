# Example

```elixir
iex> user = UsersContext.create_user!(%{username: "User1"})
iex> post = UsersContext.create_post(%{title: "My post", user_id: user.id})
iex> user = UsersContext.get_user_by!(id: user.id)
iex> users = UsersContext.filter_users(username: "User1")
```