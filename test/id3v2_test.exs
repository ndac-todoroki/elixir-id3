defmodule ID3Test do
  use ExUnit.Case
  # doctest ID3
  @path_to_sample_mp3 "priv/sample_mp3/WAKADINALI-Morio-Anzenza-Ft-Dyana-Cods.mp3"

  describe "get_tag" do
    test "get_tag!/1: return ID3_struct when valid mp3 path provided" do
      assert %ID3.Tag{} = ID3.get_tag!(@path_to_sample_mp3)
    end

    test "get_tag/1: return {:ok, ID3_struct} when valid mp3 path provided" do
      assert {
               :ok,
               %ID3.Tag{}
             } = ID3.get_tag(@path_to_sample_mp3)
    end

    test "get_tag/1: return error tuple when invalid path provided" do
      assert {:error, :file_open_error} = ID3.get_tag("")
    end
  end

  describe "write_tag" do
    test "write_tag/2" do
      # get file with year: nil
      assert {
               :ok,
               %ID3.Tag{
                 year: nil
               } = tag
             } = ID3.get_tag(@path_to_sample_mp3)

      # write tag year: 2020
      ID3.write_tag(%{tag | year: 2020}, @path_to_sample_mp3)
      # assert tag year: 2020
      assert {
               :ok,
               %ID3.Tag{year: 2020} = tag
             } = ID3.get_tag(@path_to_sample_mp3)

      on_exit(fn ->
        IO.puts(
          "#{__MODULE__}.on_exit/1 cleaning up test: write_tag/2 -> resetting test file to initial tag"
        )

        ID3.write_tag(%{tag | year: nil}, @path_to_sample_mp3)

        assert {
                 :ok,
                 %ID3.Tag{year: nil}
               } = ID3.get_tag(@path_to_sample_mp3)
      end)
    end
  end
end
