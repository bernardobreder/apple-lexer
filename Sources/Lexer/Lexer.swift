//
//  Lexer.swift
//  Lexer
//
//  Created by Bernardo Breder on 18/01/17.
//
//

import Foundation

open class Lexer {
    
    var keywords: [String: (String) -> Int] = [:]
    
    public var number: ((String) -> Int)?
    
    public var string: ((String) -> Int)?
    
    public var comment: ((String) -> Int)?
    
    public var identifier: ((String) -> Int)?
    
    public var symbol: ((String) -> Int)?
    
    public init() {
    }
    
    open func lex(input: String) throws -> [Token] {
        var result: [Token] = [], line: Int = 1, column: Int = 1
        let chars: [UnicodeScalar] = (input.unicodeScalars + ["\n".unicodeScalars.first!]).map({$0})
        let count: Int = chars.count
        var array: [UnicodeScalar] = []
        var i: Int = 0
        while i < count {
            var c: UnicodeScalar = chars[i]
            let next: UnicodeScalar = i + 1 < count ? chars[i + 1] : "\n"
            if c == "\n" { line += 1; column = 1 }
            else { column += 1 }
            if c.value <= 32 { i += 1; continue }
            array.removeAll(keepingCapacity: true)
            if c >= "0" && c <= "9" {
                array.append(c)
                repeat {
                    i += 1; guard i < count else { break }
                    c = chars[i]
                    array.append(c)
                    column += 1
                } while (c >= "0" && c <= "9") || c == "."
                let word: String = String(String.UnicodeScalarView() + array.dropLast())
                let type: Int = number?(word) ?? TokenType.number.rawValue
                result.append(Token(word: String(word), type: type, line: line, column: column))
            } else if c == "\"" {
                repeat {
                    i += 1; guard i < count else { break }
                    c = chars[i]
                    array.append(c)
                    column += 1
                } while c != "\"" || chars[i-1] == "/"
                let word: String = String(String.UnicodeScalarView() + array.dropLast())
                let type: Int = string?(word) ?? TokenType.string.rawValue
                result.append(Token(word: String(word), type: type, line: line, column: column))
                i += 1;
                column += 1
            } else if (c >= "a" && c <= "z") || (c >= "A" && c <= "Z") {
                array.append(c)
                repeat {
                    i += 1; guard i < count else { break }
                    c = chars[i]
                    array.append(c)
                    column += 1
                } while (c >= "a" && c <= "z") || (c >= "A" && c <= "Z")
                let word: String = String(String.UnicodeScalarView() + array.dropLast())
                let type: Int = keywords[word]?(word) ?? identifier?(word) ?? TokenType.identifier.rawValue
                result.append(Token(word: String(word), type: type, line: line, column: column))
            } else if c == "/" && next == "/" {
                i += 1
                repeat {
                    i += 1; guard i < count else { break }
                    c = chars[i]
                    array.append(c)
                    column += 1
                } while c != "\n"
                let word: String = String(String.UnicodeScalarView() + array.dropLast())
                let type: Int = comment?(word) ?? TokenType.comment.rawValue
                result.append(Token(word: String(word), type: type, line: line, column: column))
            } else {
                i += 1
                array.append(c)
                var word: String = String(String.UnicodeScalarView() + array)
                var type: Int = keywords[word]?(word) ?? symbol?(word) ?? TokenType.symbol.rawValue
                let word2: String = word + String(String.UnicodeScalarView() + [chars[i]])
                if let type2: Int = keywords[word2]?(word2) {
                    type = type2; word = word2; i += 1
                    let word3: String = word2 + String(String.UnicodeScalarView() + [chars[i]])
                    if let type3: Int = keywords[word3]?(word3) {
                        type = type3; word = word3; i += 1
                    }
                }
                result.append(Token(word: String(word), type: type, line: line, column: column))
            }
        }
        return result
    }
    
    public func keyword(_ pattern: String, type: @escaping (String) -> Int) {
        keywords[pattern] = type
    }
    
}

public enum LexerError: Error {
    case lexer(String)
}
