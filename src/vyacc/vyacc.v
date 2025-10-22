module vyacc

pub struct Token {
	type   string
	lexeme string
mut:
	line   int
	column int
}

pub type MatcherFn = fn (input string) ?int

pub type ActionFn = fn (lexeme string) Token

pub struct Rule {
	name    string
	matcher MatcherFn = unsafe { nil }
	action  ActionFn  = unsafe { nil }
}

pub struct Vlex {
	rules []Rule
}

pub fn Vlex.new(rules []Rule) Vlex {
	return Vlex{
		rules: rules
	}
}

pub fn new(rules []Rule) Vlex {
	return Vlex.new(rules)
}

fn (mut lexer Vlex) tokenize(input string) []Token {
	mut tokens := []Token{}
	mut pos := 0
	mut line := 1
	mut col := 1

	for pos < input.len {
		suffix := input[pos..]
		mut matched := false
		for rule in lexer.rules {
			len_match := rule.matcher(suffix) or { continue }
			lexeme := suffix[..len_match]
			mut token := rule.action(lexeme)
			token.line = line
			token.column = col
			tokens << token

			for ch in lexeme {
				if ch == `\n` {
					line++
					col = 1
				} else {
					col++
				}
			}
			pos += len_match
			matched = true
			break
		}
		if !matched {
			lexeme := input[pos..pos + 1]
			tokens << Token{
				type:   'ILLEGAL'
				lexeme: lexeme
				line:   line
				column: col
			}
			pos++
			col++
		}
	}
	return tokens
}
