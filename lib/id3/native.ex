defmodule ID3.Native do
  @moduledoc """
  This module bonds the Rust native code as Erlang NIFs.

  Functions here should not be used directly. Use `ID3` module instead.
  """

  use Rustler, otp_app: :id3, crate: :id3

  alias ID3.Tag

  # When loading a NIF module, dummy clauses for all NIF function are required.
  # NIF dummies usually just error out when called when the NIF is not loaded, as that should never normally happen.

  @spec get_major_frames(Path.t()) :: {:ok, ID3.Tag.t()} | {:error, :file_open_error}
  def get_major_frames(_path), do: :erlang.nif_error(:nif_not_loaded)

  @spec write_major_frames(Path.t(), Tag.t()) ::
          :ok | {:error, :file_open_error | :tag_write_error}
  def write_major_frames(_path, %Tag{} = _frames), do: :erlang.nif_error(:nif_not_loaded)
end
