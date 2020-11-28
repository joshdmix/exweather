defmodule Exweather.CLI do
  @default_zip 40204
  @moduledoc """
  """

  alias Exweather.Request

  def main(argv) do
    argv |> parse_args |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _} ->
        :help

      {_, [zip], _} ->
        zip

      {_, [], _} ->
        @default_zip

      _ ->
        :help
    end
  end

  def process(:help) do
    IO.puts("""
       usage: exweather { zip | #{@default_zip}}
    """)

    System.halt(0)
  end

  def process(args) do
    Request.fetch(args)
  end
end
