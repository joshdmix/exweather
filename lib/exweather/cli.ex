defmodule Exweather.CLI do
  @default_city "Louisville"
  @default_state "KY"
  @moduledoc """
  """

  alias Exweather.Request

  def main(argv) do
    argv |> parse_args |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _} -> :help

      {_, [city, state], _} ->
        {city, state}

      {_, [city], _} ->
        {city, nil}

      {_, [], _} ->
        {@default_city, @default_state}

      _ -> :help
    end
  end

  def process(:help) do
    IO.puts("""
        usage: exweather { city | #{@default_city}} , { state | #{@default_state}}
     """)

     System.halt(0)
  end

  def process(args) do
    Request.fetch(args)
  end
end
