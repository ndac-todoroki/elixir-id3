defmodule ID3Test do
  use ExUnit.Case
  # doctest ID3

  describe "get_tag" do
    test "get_tag!/1: return ID3_struct when valid mp3 path provided" do
      assert %ID3.Tag{} =
               ID3.get_tag!("/Users/cmush/Downloads/WAKADINALI-Morio-Anzenza-Ft-Dyana-Cods.mp3")
    end

    test "get_tag/1: return {:ok, ID3_struct} when valid mp3 path provided" do
      assert {
               :ok,
               %ID3.Tag{}
             } = ID3.get_tag("/Users/cmush/Downloads/WAKADINALI-Morio-Anzenza-Ft-Dyana-Cods.mp3")
    end

    test "get_tag/1: return error tuple when invalid path provided" do
      assert {:error, :file_open_error} = ID3.get_tag("")
    end
  end
end
