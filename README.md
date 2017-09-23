# Introdução

...

```javascript
Token {
    word: String
    type: int
    line: int
    column: int
}
```

# Exemplo

O exemplo abaixo irá criar um Json, aplicando algumas mudanças e revertendo

```swift
let tokens: [Token] = Lexer().lex("a b c")
print(tokens.length) // 3
print(tokens[0]) // {token: "a", type: string, ...}
print(tokens[1]) // {token: "a", type: string, ...}
print(tokens[2]) // {token: "a", type: string, ...}
```


