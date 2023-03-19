## v0.1.4 (2023-03-19)

  * [feat] use top-level MaCrud module to setup contexts
  ```elixir
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
  ```


## v0.1.3 (2023-03-19)

  * [chore] remove deprecated functions
  * [refactor] improve AST even more, by generating helper function to get the repo

## v0.1.2 (2023-03-19)

  * [fix] `resource_name_change` function was using an empty struct, and not the argument
  * [chore] make the generated AST a bit cleaner by caching the repo lookup logic

## v0.1.1 (2023-03-19)

  * [feature] generate `resource_name_change` function to stay conform with the Phoenix generators

## v0.1.0 (2023-03-19)

### First release

  * No dependency on Absinthe
  * Update dev dependencies
  * Fix compilation warnings
  * Add an example project to test-drive features from the user perspective
