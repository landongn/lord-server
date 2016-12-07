defmodule Server.Router do
  use Server.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Server.Auth, repo: Server.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Server do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    post "/login", PageController, :login
    get "/login", PageController, :login_form

    post "/logout", PageController, :logout

    resources "/classes", ClassController
  end
end
