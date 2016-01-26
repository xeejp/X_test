defmodule Test do
  @script Path.join([__DIR__, "script.py"])

  def init do
    call(["init"])
  end

  def join(data, id) do
    call(["join", Poison.encode!(data), id])
  end

  def receive(data, received) do
    call(["receive", Poison.encode!(data), Poison.encode!(received)])
  end

  def receive(data, received, id) do
    call(["receive", Poison.encode!(data), Poison.encode!(received), id])
  end

  defp call(args) do
    case System.cmd("python", [@script] ++ args) do
      {result, 0} ->
        {:ok, Poison.decode!(result)}
      _ -> :error
    end
  end
end
