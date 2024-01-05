require 'curses'
include Curses

require_relative 'token'
require_relative 'primitive'
require_relative 'arithmetic'
require_relative 'bitwise'
require_relative 'stats'
require_relative 'relational'
require_relative 'logicOps'
require_relative 'cellVals'
require_relative 'casting'
require_relative 'grid'
require_relative 'environment'
require_relative 'parser'


# clear pre-existing values per cell and print current values
def update_grid(grid, grid_window)
  (0...grid.rows).each do |i|
    (0...grid.cols).each do |j|
      grid_window.setpos((i * 2) + 2, (j * 8) + 4)
      grid_window.addstr("       ")
      grid_window.setpos((i * 2) + 2, (j * 8) + 4)
      grid_window.addstr(grid.getCellValue(MyLVal.new(i, j, 0)).to_s)
    end
  end
end

# Overwrite all possible cell underlines
def clear_grid_highlights(grid, grid_window)
  (0...grid.rows).each do |i|
      grid_window.setpos((i * 2) + 3, 1)
      grid_window.addstr("                                                                  ")
  end
end

def viewer_click_cell(row, col, grid, read_only_window, formula_editor)
  lval = MyLVal.new(row, col, 0)

  read_only_window.setpos(2,1)
  read_only_window.addstr("                                              ")
  read_only_window.setpos(2,1)
  message = grid.getCellValue(lval).to_s
  read_only_window.addstr(message)

  formula_editor.setpos(2,1)
  formula_editor.addstr("                                                       ")
  formula_editor.setpos(2,1)
  message = grid.getCell(lval).to_s
  formula_editor.addstr(message)

  read_only_window.refresh
  formula_editor.refresh
end

Curses.init_screen
height = Curses.lines
width = Curses.cols

main_window = Curses.stdscr

main_window.setpos(10, 74)
Curses.attron(color_pair(COLOR_BLUE)|A_BOLD) {
main_window.addstr("CONTROLS: del = quit, up-arrow = edit")
}
main_window.setpos(12, 74)
Curses.attron(color_pair(COLOR_BLUE)|A_BOLD) {
main_window.addstr("Edit Process: click cell, press edit key, type new formula,")
}
main_window.setpos(13, 74)
Curses.attron(color_pair(COLOR_BLUE)|A_BOLD) {
main_window.addstr("              then press enter without excess clicking")
}

# create formula editor subwindow
formula_editor = main_window.subwin(4, 70, 1, 72)
formula_editor.box("|", "-")
formula_editor.setpos(0, 20)
formula_editor.addstr("Formula Editor")
formula_editor.refresh

# create grid subwindow
grid_window = main_window.subwin(13, 70, 1, 0)
grid_window.box("|", "-")
grid_window.setpos(0, 25)
grid_window.addstr("Grid")
grid_window.refresh

# create read-only subwindow
read_only_window = main_window.subwin(4, 70, 5, 72)
read_only_window.box("|", "-")
read_only_window.setpos(0, 23)
read_only_window.addstr("Read-Only")
read_only_window.refresh

# create grid and environment variables
grid = Grid.new(5,8)
environment = Environment.new(grid)
add1 = MyAdd.new(IntPrimitive.new(3,0), IntPrimitive.new(2,0), 0)
sub1 = MySubtraction.new(IntPrimitive.new(9,1), IntPrimitive.new(5,2), 1)
default = StringPrimitive.new("Null", 0)

# populate initial grid with default String values
(0...grid.rows).each do |i|
  (0...grid.cols).each do |j|
    cell = MyLVal.new(i, j, 0)
    grid.setCell(cell, default)
  end
end

# populate initial grid with primitive values
cell = MyLVal.new(0, 2, 0)
grid.setCell(cell, IntPrimitive.new(3, 0))
cell = MyLVal.new(0, 4, 0)
grid.setCell(cell, FloatPrimitive.new(3.14, 0))
cell = MyLVal.new(0, 6, 0)
grid.setCell(cell, BoolPrimitive.new(false, 0))

# populate initial grid with lex and parse cells
input_text = "10 >= 0"
tokenized = Token.lexer(input_text)
parser = Parser.new(tokenized)
ast = parser.parse
if (ast.evaluate(environment) != nil)
  grid.setCell(MyLVal.new(0,0,0), ast)
end

input_text = "2 << 10"
tokenized = Token.lexer(input_text)
parser = Parser.new(tokenized)
ast = parser.parse
if (ast.evaluate(environment) != nil)
  grid.setCell(MyLVal.new(4,0,0), ast)
end

input_text = "true && false"
tokenized = Token.lexer(input_text)
parser = Parser.new(tokenized)
ast = parser.parse
if (ast.evaluate(environment) != nil)
  grid.setCell(MyLVal.new(2,2,0), ast)
end

input_text = "Hello == Hello"
tokenized = Token.lexer(input_text)
parser = Parser.new(tokenized)
ast = parser.parse
if (ast.evaluate(environment) != nil)
  grid.setCell(MyLVal.new(3,3,0), ast)
end

input_text = "10 + 3"
tokenized = Token.lexer(input_text)
parser = Parser.new(tokenized)
ast = parser.parse
if (ast.evaluate(environment) != nil)
  grid.setCell(MyLVal.new(3,6,0), ast)
end

input_text = "21.1 fti"
tokenized = Token.lexer(input_text)
parser = Parser.new(tokenized)
ast = parser.parse
if (ast.evaluate(environment) != nil)
  grid.setCell(MyLVal.new(3,5,0), ast)
end

input_text = "21.1 fti"
tokenized = Token.lexer(input_text)
parser = Parser.new(tokenized)
ast = parser.parse
if (ast.evaluate(environment) != nil)
  grid.setCell(MyLVal.new(3,5,0), ast)
end

input_text = "true || false"
tokenized = Token.lexer(input_text)
parser = Parser.new(tokenized)
ast = parser.parse
if (ast.evaluate(environment) != nil)
  grid.setCell(MyLVal.new(1,1,0), ast)
end
# end adding initial values

update_grid(grid, grid_window)

# Curses and window settings
Curses.start_color
Curses.init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_BLACK)
Curses.init_pair(COLOR_RED,COLOR_RED,COLOR_BLACK)

Curses.curs_set(0)
Curses.stdscr.keypad(true)
Curses.mousemask(Curses::BUTTON1_CLICKED)
edit_mode = false
cell_selected = false
grid_row = 0
grid_col = 0

# main loop
loop do
  main_window.refresh
  grid_window.refresh
  read_only_window.refresh
  formula_editor.refresh
  command = getch

  if (edit_mode) # Edit Mode
    main_window.setpos(0,0)
    main_window.addstr("                   ")
    main_window.setpos(0,0)
    Curses.attron(color_pair(COLOR_RED)|A_BOLD) {
    main_window.addstr("EDIT MODE")
    }
    main_window.refresh

    if (cell_selected)
      formula_editor.setpos(2,1)
      formula_editor.addstr("                                        ")
      formula_editor.setpos(2,1)
      message = formula_editor.getstr
      # formula_editor.addstr(message)

      #check input type and create cell value
      if message.to_i.to_s == message
        cell = IntPrimitive.new(message, 0)
        # cell = StringPrimitive.new("INT", 0)
      elsif message.downcase == 'true' || message.downcase == 'false'
        cell = BoolPrimitive.new(message, 0)
        # cell = StringPrimitive.new("BOOL", 0)
      elsif message.to_f.to_s == message
        cell = FloatPrimitive.new(message, 0)
        # cell = StringPrimitive.new("FLO", 0)
      else

        # String default case
        cell = StringPrimitive.new(message, 0)

        if message != nil && message.length > 3
          # String parse and lex case
          if (message[0] == '=')
            message = message[1..message.length-1]

            # input_text = "10 >= 0"
            tokenized = Token.lexer(message)
            parser = Parser.new(tokenized)
            ast = parser.parse
            if (ast.evaluate(environment) != nil)
              cell = ast
            end

          end


        end
      end
      grid.setCell(MyLVal.new(grid_row, grid_col, 0), cell)
      update_grid(grid, grid_window)

      # Automatically exit edit mode to only allow single edits
      cell_selected = false
      edit_mode = false
    else
      edit_mode = false
    end

    # Manually exit edit mode (Up Arrow)
    if command == KEY_UP
      edit_mode = false
    end

  else # Viewer Mode
    main_window.setpos(0,0)
    main_window.addstr("                   ")
    main_window.setpos(0,0)
    Curses.attron(color_pair(COLOR_BLUE)|A_BOLD) {
    main_window.addstr("VIEW MODE")
    }
    main_window.refresh

    if command == Curses::KEY_DC
      break
    elsif command == KEY_MOUSE
      event = getmouse
      main_window.setpos(0, 10)
      main_window.addstr("          ")
      column = event.x - Curses.cols / 2
      row = -(event.y - Curses.lines / 2)
      Curses.attron(color_pair(COLOR_BLUE)|A_BOLD){
        main_window.setpos(0, 10)
        main_window.addstr("#{column}, #{row}")
      }

      cell_selected = true
      # coordinates for cells
      if column == -70 && row == 5
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(3,3)
        grid_window.addstr("------")

        grid_row = 0
        grid_col = 0
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      # repeat of prior if statement per coordinates
      elsif column == -62 && row == 5
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(3,11)
        grid_window.addstr("------")

        grid_row = 0
        grid_col = 1
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -54 && row == 5
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(3,19)
        grid_window.addstr("------")
        grid_row = 0
        grid_col = 2

        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -46 && row == 5
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(3,27)
        grid_window.addstr("------")

        grid_row = 0
        grid_col = 3
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -38 && row == 5
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(3,35)
        grid_window.addstr("------")

        grid_row = 0
        grid_col = 4
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -30 && row == 5
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(3,43)
        grid_window.addstr("------")

        grid_row = 0
        grid_col = 5
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -22 && row == 5
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(3,51)
        grid_window.addstr("------")

        grid_row = 0
        grid_col = 6
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -14 && row == 5
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(3,59)
        grid_window.addstr("------")

        grid_row = 0
        grid_col = 7
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -70 && row == 3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(5,3)
        grid_window.addstr("------")

        grid_row = 1
        grid_col = 0
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -62 && row == 3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(5,11)
        grid_window.addstr("------")

        grid_row = 1
        grid_col = 1
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -54 && row == 3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(5,19)
        grid_window.addstr("------")

        grid_row = 1
        grid_col = 2
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -46 && row == 3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(5,27)
        grid_window.addstr("------")

        grid_row = 1
        grid_col = 3
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -38 && row == 3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(5,35)
        grid_window.addstr("------")

        grid_row = 1
        grid_col = 4
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -30 && row == 3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(5,43)
        grid_window.addstr("------")

        grid_row = 1
        grid_col = 5
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -22 && row == 3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(5,51)
        grid_window.addstr("------")

        grid_row = 1
        grid_col = 6
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -14 && row == 3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(5,59)
        grid_window.addstr("------")

        grid_row = 1
        grid_col = 7
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -70 && row == 1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(7,3)
        grid_window.addstr("------")

        grid_row = 2
        grid_col = 0
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -62 && row == 1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(7,11)
        grid_window.addstr("------")

        grid_row = 2
        grid_col = 1
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -54 && row == 1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(7,19)
        grid_window.addstr("------")

        grid_row = 2
        grid_col = 2
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -46 && row == 1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(7,27)
        grid_window.addstr("------")

        grid_row = 2
        grid_col = 3
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -38 && row == 1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(7,35)
        grid_window.addstr("------")

        grid_row = 2
        grid_col = 4
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -30 && row == 1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(7,43)
        grid_window.addstr("------")

        grid_row = 2
        grid_col = 5
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -22 && row == 1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(7,51)
        grid_window.addstr("------")

        grid_row = 2
        grid_col = 6
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -14 && row == 1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(7,59)
        grid_window.addstr("------")

        grid_row = 2
        grid_col = 7
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -70 && row == -1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(9,3)
        grid_window.addstr("------")

        grid_row = 3
        grid_col = 0
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -62 && row == -1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(9,11)
        grid_window.addstr("------")

        grid_row = 3
        grid_col = 1
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -54 && row == -1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(9,19)
        grid_window.addstr("------")

        grid_row = 3
        grid_col = 2
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -46 && row == -1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(9,27)
        grid_window.addstr("------")

        grid_row = 3
        grid_col = 3
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -38 && row == -1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(9,35)
        grid_window.addstr("------")

        grid_row = 3
        grid_col = 4
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -30 && row == -1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(9,43)
        grid_window.addstr("------")

        grid_row = 3
        grid_col = 5
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -22 && row == -1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(9,51)
        grid_window.addstr("------")

        grid_row = 3
        grid_col = 6
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -14 && row == -1
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(9,59)
        grid_window.addstr("------")

        grid_row = 3
        grid_col = 7
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -70 && row == -3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(11,3)
        grid_window.addstr("------")

        grid_row = 4
        grid_col = 0
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -62 && row == -3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(11,11)
        grid_window.addstr("------")

        grid_row = 4
        grid_col = 1
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -54 && row == -3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(11,19)
        grid_window.addstr("------")

        grid_row = 4
        grid_col = 2
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -46 && row == -3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(11,27)
        grid_window.addstr("------")

        grid_row = 4
        grid_col = 3
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -38 && row == -3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(11,35)
        grid_window.addstr("------")

        grid_row = 4
        grid_col = 4
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -30 && row == -3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(11,43)
        grid_window.addstr("------")

        grid_row = 4
        grid_col = 5
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -22 && row == -3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(11,51)
        grid_window.addstr("------")

        grid_row = 4
        grid_col = 6
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      elsif column == -14 && row == -3
        clear_grid_highlights(grid, grid_window)
        grid_window.setpos(11,59)
        grid_window.addstr("------")

        grid_row = 4
        grid_col = 7
        viewer_click_cell(grid_row, grid_col, grid, read_only_window, formula_editor)
      else
        clear_grid_highlights(grid, grid_window)
        cell_selected = false
      end
    elsif command == KEY_UP
      edit_mode = true
    end
  end
end

Curses.close_screen

# ERROR EXAMPLES TO DISPLAY
# ----------------------------------------------------
# =WHAT / 1         EVAL ERROR MESSAGE
# =3 + -            ATOM ERROR MESSAGE
# =9 10 /           EXPRESSION ERROR MESSAGE
