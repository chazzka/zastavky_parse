defmodule Parse do
  @moduledoc """
  Documentation for `Parse`.
  """

  def parse(file) do
    case File.read(file) do
      {:ok, content} ->
        content
        |> String.split(~r/;|\R+/)
        |> Enum.reject(&(&1 == ""))

      {:error, reason} ->
        IO.puts("Chyba při čtení souboru: #{reason}")
        []
    end
  end

  def process_lines(lines) do
    lines
    # Rozdělení každého prvku podle ",
    |> Stream.map(&Regex.split(~r/",\s*/, &1))
    # Odstranění uvozovek
    |> Enum.map(&Enum.map(&1, fn x -> String.trim(x, "\"") end))
    |> Enum.map(fn row ->
      case row do
        [first, second | rest] -> [first, convert_cp1250_to_utf8(second) | rest]
        _ -> row
      end
    end)
  end

  defp convert_cp1250_to_utf8(binary) when is_binary(binary) do
    tmp_input = "/tmp/iconv_input.txt"
    tmp_output = "/tmp/iconv_output.txt"

    # Uložení vstupu do souboru
    File.write!(tmp_input, binary)

    # Spuštění iconv a uložení výsledku
    System.cmd("iconv", ["-f", "CP1250", "-t", "UTF-8", tmp_input, "-o", tmp_output])

    # Načtení převedeného souboru
    File.read!(tmp_output)
    |> String.trim()
  end

  defp convert_cp1250_to_utf8(value), do: value
end
