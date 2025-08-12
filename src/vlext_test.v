module vlex

fn match_integer(input string) ?int {
	mut i := 0
	for i < input.len && input[i].is_digit() {
		i++
	}
	if i == 0 {
		return none
	}
	return i
}

fn match_float(input string) ?int {
	mut i := 0
	for i < input.len && input[i].is_digit() {
		i++
	}
	if i < input.len && input[i] == `.` {
		i++
		mut frac_start := i
		for i < input.len && input[i].is_digit() {
			i++
		}
		if i > frac_start {
			return i
		}
	}
	return none
}

fn match_whitespace(input string) ?int {
	mut i := 0
	for i < input.len
		&& (input[i] == ` ` || input[i] == `\t` || input[i] == `\n` || input[i] == `\r`) {
		i++
	}
	if i == 0 {
		return none
	}
	return i
}

fn match_identifier(input string) ?int {
	if input.len == 0 {
		return none
	}
	if !(input[0].is_letter() || input[0] == `_`) {
		return none
	}
	mut i := 1
	for i < input.len && (input[i].is_letter() || input[i].is_digit() || input[i] == `_`) {
		i++
	}
	return i
}

fn match_string(input string) ?int {
	if input.len == 0 || input[0] != `"` {
		return none
	}
	mut i := 1
	mut escaped := false
	for i < input.len {
		ch := input[i]
		if escaped {
			escaped = false
		} else if ch == `\\` {
			escaped = true
		} else if ch == `"` {
			return i + 1
		}
		i++
	}
	return none
}

fn match_single_line_comment(input string) ?int {
	if !input.starts_with('//') {
		return none
	}
	mut i := 2
	for i < input.len && input[i] != `\n` {
		i++
	}
	return i
}

fn match_symbol(input string) ?int {
	symbols := ['+', '-', '*', '/', '=', ';', '(', ')', '{', '}', ',']
	for sym in symbols {
		if input.starts_with(sym.str()) {
			return sym.len
		}
	}
	return none
}

fn action_integer(lexeme string) Token {
	return Token{
		type:   'INTEGER'
		lexeme: lexeme
		line:   0
		column: 0
	}
}

fn action_float(lexeme string) Token {
	return Token{
		type:   'FLOAT'
		lexeme: lexeme
		line:   0
		column: 0
	}
}

fn action_whitespace(lexeme string) Token {
	return Token{
		type:   'WHITESPACE'
		lexeme: lexeme
		line:   0
		column: 0
	}
}

fn action_identifier(lexeme string) Token {
	return Token{
		type:   'IDENTIFIER'
		lexeme: lexeme
		line:   0
		column: 0
	}
}

fn action_string(lexeme string) Token {
	return Token{
		type:   'STRING'
		lexeme: lexeme
		line:   0
		column: 0
	}
}

fn action_comment(lexeme string) Token {
	return Token{
		type:   'COMMENT'
		lexeme: lexeme
		line:   0
		column: 0
	}
}

fn action_symbol(lexeme string) Token {
	return Token{
		type:   'SYMBOL'
		lexeme: lexeme
		line:   0
		column: 0
	}
}

fn test_vlex() {
	rules := [
		Rule{
			name:    'whitespace'
			matcher: match_whitespace
			action:  action_whitespace
		},
		Rule{
			name:    'single_line_comment'
			matcher: match_single_line_comment
			action:  action_comment
		},
		Rule{
			name:    'float'
			matcher: match_float
			action:  action_float
		},
		Rule{
			name:    'integer'
			matcher: match_integer
			action:  action_integer
		},
		Rule{
			name:    'string'
			matcher: match_string
			action:  action_string
		},
		Rule{
			name:    'identifier'
			matcher: match_identifier
			action:  action_identifier
		},
		Rule{
			name:    'symbol'
			matcher: match_symbol
			action:  action_symbol
		},
	]

	mut lexer := new(rules)

	input := '
    // Ceci est un commentaire
    var x = 123
    var y = 3.14
    var s = "Hello, "world"!"
    '
	tokens := lexer.tokenize(input)

	for t in tokens {
		if t.type != 'WHITESPACE' {
			println('${t.line}:${t.column} [${t.type}] -> "${t.lexeme}"')
		}
	}
}
