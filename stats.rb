# The statistical functions all accept two cell lvalues (addresses) 
class MyMax
  attr_reader :location

  def initialize(addr1, addr2, location)
    @addr1 = addr1
    @addr2 = addr2
    @location = location
  end
 
  def evaluate(environment)
    if !(@addr1.is_a? MyLVal)
      raise "Syntax error: invalid arguments for MyMax at #{@addr1.location}"
    end

    if !(@addr2.is_a? MyLVal)
      raise "Syntax error: invalid arguments for MyMax at #{@addr2.location}"
    end
        
    max = nil
    for row in (@addr1.row..@addr2.row)
      for col in (@addr1.col..@addr2.col)
        value = environment.getCellValue(row, col)
        max = value if max.nil? || value > max
      end
    end
    
    return max
  end
    
  def to_s
    "MyMax ( #{@addr1.to_s}), (#{@addr2.to_s}, #{@location} )"
  end
end

class MyMin
  attr_reader :location

  def initialize(addr1, addr2, location)
    @addr1 = addr1
    @addr2 = addr2
    @location = location
  end
    
  def evaluate(environment)
        
    if !(@addr1.is_a? MyLVal)
      raise "Syntax error: invalid arguments for MyMin at #{@addr1.location}"
    end

    if !(@addr2.is_a? MyLVal)
      raise "Syntax error: invalid arguments for MyMin at #{@addr2.location}"
    end
        
    min = nil
    for row in (@addr1.row..@addr2.row)
      for col in (@addr1.col..@addr2.col)
        value = environment.getCellValue(row, col)
        min = value if min.nil? || value < min
      end
    end
    
    return min
  end
    
  def to_s
    "MyMin ( #{@addr1.to_s}), (#{@addr2.to_s}, #{@location} )"
  end  
end

class MyMean
  attr_reader :location

  def initialize(addr1, addr2, location)
    @addr1 = addr1
    @addr2 = addr2
    @location = location
  end
    
  def evaluate(environment)   
    if !(@addr1.is_a? MyLVal)
      raise "Syntax error: invalid arguments for MyMean at #{@addr1.location}"
    end

    if !(@addr2.is_a? MyLVal)
      raise "Syntax error: invalid arguments for MyMean at #{@addr2.location}"
    end
        
    totalValues = 0
    sum = nil
    for row in (@addr1.row..@addr2.row)
      for col in (@addr1.col..@addr2.col)
        value = environment.getCellValue(row, col)
        totalValues = totalValues + 1
        if sum.nil?
          sum = sum
        else
          sum = sum + value
        end
      end
    end
    
    return (sum / totalValues)
  end
    
  def to_s
    "MyMean ( #{@addr1.to_s}), (#{@addr2.to_s}, #{@location} )"
  end

end

class MySum
  attr_reader :location

  def initialize(addr1, addr2, location)
    @addr1 = addr1
    @addr2 = addr2
    @location = location
  end
    
  def evaluate(environment)
        
    if !(@addr1.is_a? MyLVal)
      raise "Syntax error: invalid arguments for MySum at #{@addr1.location}"
    end

    if !(@addr2.is_a? MyLVal)
      raise "Syntax error: invalid arguments for MySum at #{@addr2.location}"
    end
        
    sum = nil
    for row in (@addr1.row..@addr2.row)
      for col in (@addr1.col..@addr2.col)
        value = environment.getCellValue(row, col)
        if sum.nil?
          sum = sum
        else
          sum = sum + value
        end
      end
    end
    
    return sum
  end
    
  def to_s
    "MySum (#{@addr1.to_s}), (#{@addr2.to_s}, #{@location} )"
  end
end