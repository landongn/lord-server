defmodule Server.Plug.Authenticate do
  @behaviour Plug
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _) do
    if conn.assigns.token do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page.")
      |> redirect(to: Server.Router.Helpers.index_path(conn, :login_form))
      |> halt()
    end
  end
end