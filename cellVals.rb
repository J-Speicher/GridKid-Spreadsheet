#address (x, y)
class MyLVal
  attr_reader :row
  attr_reader :col
  attr_reader :location 

  def initialize(row,col,location)
    @row = row
    @col = col
    @location = location
  end

  def evaluate(environment)
    # Here are some type checks!
    if @row.class == (IntPrimitive)
      @row = @row.evaluate(environment)
    end

    if @col.class == IntPrimitive
      @col = @col.evaluate(environment)
    end


    if @row.is_a?(Integer) 
      if @col.is_a?(Integer)
        environment.getCell(self)
      else
        raise "Syntax error: invalid argument for MyLVal at: #{@col}"
      end
    else
      raise "Syntax error: invalid argument for MyLVal at: #{@row}"
    end
  end

  def to_s
    "MyLVal ( #{@row.to_s},#{@col.to_s}, #{@location} )"
  end

end

#value
class MyRVal
  attr_reader :row
  attr_reader :col
  attr_reader :location 

  def initialize(row,col,location)
    @row = row
    @col = col
    @location = location
  end

  def evaluate(environment)
    if @col.is_a?(Integer)
      if @col.is_a?(Integer)
          environment.getCellValue(self)
      else
        raise "Syntax error: invalid argument for MyModulo at: #{@col}"
      end
    else
      raise "Syntax error: invalid argument for MyModulo at: #{@row}"
    end
  end

  def row
    @row
  end

  def col
    @col
  end

  def to_s
    "MyRVal ( #{@row.to_s},#{@col.to_s}, #{@location} )"
  end
end