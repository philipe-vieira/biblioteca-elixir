import Config

config :bibl, Bibl.Repo,
  database: "bibl_repo",
  username: "default",
  password: "secret",
  hostname: "localhost",
  log: false

config :bibl, ecto_repos: [Bibl.Repo]
