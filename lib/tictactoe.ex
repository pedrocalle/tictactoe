defmodule Tictactoe do
  def game(board) do
      check_win?(board)
      |>case do
        {true, x} -> winner(board, x)
        false ->
        if check_full?(board) do
          IO.inspect("Deu velha!")
        else
          check_turn(board)
        end
      end
    end

    def check_win?([
      [x, x, x],
      [_, _, _],
      [_, _, _]
    ]) when x != "", do: {true, x}

    def check_win?([
      [_, _, _],
      [x, x, x],
      [_, _, _]
    ]) when x != "", do: {true, x}

    def check_win?([
      [_, _, _],
      [_, _, _],
      [x, x, x]
    ]) when x != "", do: {true, x}

    def check_win?([
      [x, _, _],
      [x, _, _],
      [x, _, _]
    ]) when x != "", do: {true, x}

    def check_win?([
      [_, x, _],
      [_, x, _],
      [_, x, _]
    ]) when x != "", do: {true, x}

    def check_win?([
      [_, _, x],
      [_, _, x],
      [_, _, x]
    ]) when x != "", do: {true, x}

    def check_win?([
      [x, _, _],
      [_, x, _],
      [_, _, x]
    ]) when x != "", do: {true, x}

    def check_win?([
      [_, _, x],
      [_, x, _],
      [x, _, _]
    ]) when x != "", do: {true, x}

    def check_win?(_board), do: false

    def winner(board, value) do
      display_board(board)
      IO.inspect("O Jogador vencedor foi: #{value}")
    end

    def insert({board, player}) do
      display_board(board)
      line_index = IO.gets("Digite em qual linha deseja inserir: ")
      |>String.trim()
      |>String.to_integer()

      line = Enum.at(board, line_index)
      column = IO.gets("Digite em qual coluna deseja inserir:")
      |>String.trim()
      |>String.to_integer()

      updated_line = List.replace_at(line, column, player)
      List.replace_at(board, line_index, updated_line)
      |>game()

    end

    def check_turn(board) do
      {o, x} = Enum.reduce(board, {0, 0}, fn line, {acc_o, acc_x} ->
        Enum.reduce(line, {acc_o, acc_x}, fn field, {o_count, x_count} ->
          case field do
            "O" -> {o_count + 1, x_count}
            "X" -> {o_count, x_count + 1}
            "" -> {o_count, x_count}
          end
        end)
      end)

      cond do
        o > x -> insert({board, "X"})
        o == x -> insert({board, "O"})
      end
    end

    def check_full?(board) do
      board
      |> List.flatten()
      |> Enum.all?(fn field -> field != "" end)
    end

    def display_board(board) do
      board
      |> Enum.each(fn line ->
        IO.inspect(line)
      end)
    end
end
