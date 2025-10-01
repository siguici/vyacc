# 📘 Vyacc – LALR(1) Parser Generator in V

> **Vyacc** is a **LALR(1) parser generator** written in [Vlang](https://vlang.io),
inspired by Yacc/Bison but designed to be **modern, simple, and modular**.  
> Its main goal is to make the development of programming languages, DSLs,
and robust parsers **easier and more efficient**.  

---

## 🚀 Features

- 📚 Full support for **LALR(1) grammars**  
- 🛠 Automatic **AST (Abstract Syntax Tree)** generation  
- 🏎 Native performance powered by V  
- 🎯 Clear syntax, familiar to **Yacc/Bison** users  
- 🔗 Easy integration with your V projects  

---

## ⚙️ Installation

### 🔹 Via VPM (Recommended)

```sh
v install siguici.vyacc
````

📦 [Vyacc on VPM](https://vpm.vlang.io/packages/siguici.vyacc)

---

### 🔹 Via Git

```sh
mkdir -p ${VMODULES:-$HOME/.vmodules}/siguici
git clone --depth=1 https://github.com/siguici/vyacc ${VMODULES:-$HOME/.vmodules}/siguici/vyacc
```

---

### 🔹 As a project dependency

In your `v.mod` file:

```vmod
Module {
  dependencies: ['siguici.vyacc']
}
```

---

### 🔹 Native installers

The repository also provides native installers for manual installation:

- **Linux / macOS** : `install.sh`
- **Windows** : `install.ps1`

---

## 🖥 Usage

Minimal example of a grammar file `example.y`:

```yacc
%token NUMBER
%left '+' '-'
%left '*' '/'

%%
expr: expr '+' expr   { $$ = $1 + $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | NUMBER          { $$ = $1; }
    ;
```

Generate the parser:

```sh
vyacc example.y -o parser.v
v run parser.v
```

---

## 🧪 Testing

```sh
v test .
```

---

## 🤝 Contributing

Contributions are **welcome**!

- Fork the repository
- Create a branch `feature/my-feature`
- Submit a PR 🚀

---

## 📜 License

Vyacc is distributed under the [**MIT License**](/LICENSE.md).
You are free to use, modify, and share it.

Made with ❤️ by [Sigui Kessé Emmanuel](https://github.com/siguici).
