class Token

    TOKENS = {
      INTPRIMITIVE: /\A\d+\z/,
      FLOATPRIMITIVE: /\A\d+\.\d+\z/,
      BOOLPRIMITIVE: /\A(true|false)\z/,
      MYADD: /\+\z/,
      MYSUBTRACTION: /\-\z/,
      MYDIV: /\/\z/,
      MYEXPONENTIATION: /\*\*\z/,
      MYMULT: /\*\z/,
      MYMODULO: /\%\z/,
      MYLAND: /\&\&\z/,
      MYBITAND: /\&\z/,
      MYLOR: /\|\|\z/,
      MYBITOR: /\|\z/,
      MYBITXOR: /\^\z/,
      MYBITNOT: /\~\z/,
      MYBITLSHIFT: /\<\<\z/,
      MYBITRSHIFT: /\>\>\z/,
      MYLVAL: /\b(L)\b/,
      MYRVAL: /\b(R)\b/,
      MYLNOT: /\!\z/,
      MYEQUALS: /\=\=\z/,
      MYNOTEQUALS: /\!\=\z/,
      MYLESSTHAN: /\<\z/,
      MYGREATERTHAN: /\>\z/,
      MYLESSTHANOREQUAL: /\<\=\z/,
      MYGREATERTHANOREQUAL: /\>\=\z/,
      MYMAX: /\bmax\b/,
      MYMIN: /\bmin\b/,
      MYMEAN: /\bmean\b/,
      MYSUM: /\bsum\b/,
      MYFLOATTOINT: /\bfti\b/,     # simple abbreviation for float to int (fti)
      MYINTTOFLOAT: /\bitf\b/,      # int to float (itf)
      STRINGPRIMITIVE: /\A[a-zA-Z]+\z/

    }

    attr_reader :token_type, :text, :start_index, :end_index

    def initialize(token_type, text, start_index, end_index)
      @token_type = token_type
      @text = text
      @start_index = start_index
      @end_index = end_index
    end

    def to_s
      "(:#{token_type}, '#{text}', #{start_index}, #{end_index})"
    end

    def self.lexer(input_text)
      tokens = []
      index = 0

      input_text.split.each_with_index do |token_text, i|
        token_type = TOKENS.find { |type, regex| token_text.match(regex) }

        if token_type
          tokens << Token.new(token_type[0], token_text, index, index + token_text.length - 1)
        else
          puts("Unknown type found at index #{index}: '#{token_text}'")
        end

        index += token_text.length + 1
      end

      tokens
    end
end

  # --------- EXAMPLE 1 --------- show all types

  # input_text = "5 31.1 true 00 0o breh % << >> & ! == [[2][2]] (L) max"
  # tokenized = Token.lexer(input_text)

  # tokenized.each do |token|
  #   puts token.to_s
  # end

  # --------- EXAMPLE 2 --------- show organized input-output

  # input_text = "10.2 >> 3.1"
  # tokenized = Token.lexer(input_text)

  # tokenized.each do |token|
  #   puts token.to_s
  # end
