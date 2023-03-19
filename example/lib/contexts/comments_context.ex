defmodule CommentsContext do
  use MaCrud
  MaCrud.generate(Example.Comment, repo: Example.Repo)
end