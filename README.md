# Vlex ⚡️

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**Vlex** is a **general-purpose**, lightweight, and flexible lexer written in **Vlang**,
inspired by classic tools like Flex.  
It allows you to define lexical rules dynamically (patterns + actions)
and tokenize any input text with ease.

---

## 🚀 Features

- 🔧 Define custom lexical rules with simple patterns and associated actions  
- 🔢 Supports common token types: integers, floats, identifiers, strings,
comments, symbols, whitespace, and more  
- ❌ Detects lexical errors and returns `ILLEGAL` tokens for invalid input  
- 📍 Tracks line and column positions for each token  
- 🧩 Modular and extensible architecture for easy addition of new token types  
- 🛠️ Pure Vlang implementation with **no external dependencies**  

---

## ⚙️ Installation

### Via VPM (Recommended)

```sh
v install siguici.vlex
```

### Via Git

```sh
mkdir -p ${V_MODULES:-$HOME/.vmodules}/siguici
git clone --depth=1 https://github.com/siguici/vlex ${V_MODULES:-$HOME/.vmodules}/siguici/vlex
```

### As a project dependency

```v
Module {
  dependencies: ['siguici.vlex']
}
```

---

## 📝 Usage

Create an array of `Rule` objects specifying how to match tokens
and their corresponding actions.
Instantiate a `Vlex` lexer with these rules,
then call `tokenize(input_string)` to get all tokens.

```v
import siguici.vlex

fn main() {
    rules := [ /* your rules here */ ]
    mut lexer := vlex.new(rules)
    tokens := lexer.tokenize("your code here")

    for token in tokens {
        println('${token.line}:${token.column} [${token.typ}] -> "${token.lexeme}"')
    }
}
```

---

## 🤝 Contributing

Contributions are very welcome!
Please fork the repository, create a feature branch, and submit a pull request.
Feel free to open issues or discussions for bugs, features, or improvements.

---

## 📄 License

This project is licensed under the MIT License.
See the [LICENSE](LICENSE) file for details.

---

## 💡 About

Vlex is designed to be a foundation for building custom lexers in Vlang,
allowing flexible token definitions and easy integration into parsers
or other analysis tools.

---

Happy lexing! 🎉
