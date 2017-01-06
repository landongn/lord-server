defmodule Server.Router do
  use Server.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Server.SessionPlug, repo: Server.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Server.AdminPlug, repo: Server.Repo
  end

  scope "/", Server do
    pipe_through :browser # Use the default browser stack

    get "/", IndexController, :index

    get "/signup", IndexController, :signup
    get "/about", IndexController, :about
    get "/subscribe", IndexController, :subscribe
    get "/play", IndexController, :play
    get "/login", IndexController, :login_form

    post "/login", IndexController, :login
    post "/signup", IndexController, :register

    # new prototype area for threejs

    get "/the-oasis-of-marr", IndexController, :theoasis
    get "/high-class-flatulence", IndexController, :game
    get "/patchnotes", UpdateController, :index
  end

  scope "/cms", Server do
    pipe_through :authenticated
    resources "/classes", ClassController
    resources "/updates", UpdateController
  end
end
