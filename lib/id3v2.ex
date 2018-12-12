defmodule ID3V2 do
  @moduledoc """
  Documentation for ID3V2.
  """

  use Rustler, otp_app: :id3v2, crate: :id3v2

  # When loading a NIF module, dummy clauses for all NIF function are required.
  # NIF dummies usually just error out when called when the NIF is not loaded, as that should never normally happen.

  @spec add(integer, integer) :: {:ok, integer}
  def add(_num1, _num2), do: :erlang.nif_error(:nif_not_loaded)
end
