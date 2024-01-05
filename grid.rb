class Grid
  attr_reader :rows
  attr_reader :cols

  def initialize(rows, cols)
    # Good multidimensional array allocation.
    @rows = rows
    @cols = cols
    @grid = Array.new(rows) { Array.new(cols) }
  end

  def setCell(addr, expression)
    @grid[addr.row][addr.col] = expression
  end

  def getCell(addr)
    if (addr.class == MyLVal)
      @grid[addr.row][addr.col]
    end
  end

  def getCellValue(addr)
    expression = getCell(addr)
    return nil if expression.nil?

    expression.evaluate(Environment.new(self))
  end

  def validAddress?(address)
    # Thank you for not using an if statement.
    address.row >= 0 && address.row < @grid.length &&
      address.col >= 0 && address.col < @grid[0].length
  end

  def to_s
    "Grid ( [#{@rows}][#{@cols}] )"
  end
end

# --------------------------- Example Use ---------------------------


# require_relative 'arithmetic'
# require_relative 'primitive'
# require_relative 'environment'
# require_relative 'bitwise'
# require_relative 'casting'
# require_relative 'cellVals'
# require_relative 'logicOps'
# require_relative 'relational'
# require_relative 'stats'

# grid = Grid.new(5, 5)
# env = Environment.new(grid)

# lVal1 = MyLVal.new(2, 3, 0)
# lVal2 = MyLVal.new(1, 1, 0)
# lVal3 = MyLVal.new(4, 2, 0)
# lVal4 = MyLVal.new(3, 5, 0)

# # # Set expressions in cells
# grid.setCell(lVal1, MyAdd.new(IntPrimitive.new(5, 0), IntPrimitive.new(3, 0), 0))
# grid.setCell(lVal2, MyBitXor.new(IntPrimitive.new(2, 0), IntPrimitive.new(8, 0), 0))
# grid.setCell(lVal3, MyLAnd.new(BoolPrimitive.new(true, 0), BoolPrimitive.new(true, 0), 0))
# grid.setCell(lVal4, MyGreaterThan.new(FloatPrimitive.new(1.37, 0), FloatPrimitive.new(2.11, 0), 0))

# # # Evaluate and print the value of a cell
# result = env.getCellValue(lVal1)
# puts result
# result = env.getCellValue(lVal2)
# puts result
# result = env.getCellValue(lVal3)
# puts result
# result = env.getCellValue(lVal4)
# puts result
