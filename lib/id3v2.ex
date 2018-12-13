defmodule ID3V2 do
  @moduledoc """
  Documentation for ID3V2.
  """

  alias ID3V2.Native

  defdelegate get_tag(path), to: Native, as: :get_major_frames
  defdelegate write_tag(path, tag), to: Native, as: :write_major_frames
end
