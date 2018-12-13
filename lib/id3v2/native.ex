defmodule ID3V2.Native do
  @moduledoc """
  Import position of Rust native code.
  """

  use Rustler, otp_app: :id3v2, crate: :id3v2

  alias ID3V2.Tag

  # When loading a NIF module, dummy clauses for all NIF function are required.
  # NIF dummies usually just error out when called when the NIF is not loaded, as that should never normally happen.

  @spec get_major_frames(Path.t()) :: {:ok, ID3V2.Tag.t()} | {:error, :file_open_error}
  def get_major_frames(_path), do: :erlang.nif_error(:nif_not_loaded)

  @spec write_major_frames(Path.t(), Tag.t()) ::
          :ok | {:error, :file_open_error | :tag_write_error}
  def write_major_frames(_path, %Tag{} = _frames), do: :erlang.nif_error(:nif_not_loaded)
end
