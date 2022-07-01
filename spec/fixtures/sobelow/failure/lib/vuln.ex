defmodule Bad do
  def bad_func(input) do
    Code.eval_string(input) ## The horror
  end

  def query(%{"sql" => sql}) do
      Repo.query(sql)
  end

  def index(conn, %{"test" => test}) do
    render conn, :"foo\#{test}"
  end

  # def index(conn, params) do
  #   render conn, :"foo\#{params["test"]}"
  # end

end
