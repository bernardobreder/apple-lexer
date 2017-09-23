//
//  Lexer.swift
//  Lexer
//
//  Created by Bernardo Breder on 18/01/17.
//
//

import XCTest
@testable import Lexer

class LexerTests: XCTestCase {

	func test() throws {
        XCTAssertEqual(["1", "+", "2"], try Lexer().lex(input: "1 + 2").map({$0.word}))
        XCTAssertEqual(["1", "+", "2"], try Lexer().lex(input: "\"1\" + \"2\"").map({$0.word}))
	}
    
    func test2Symbol() throws {
        let lexer = Lexer()
        lexer.symbol = { _ in 1 }
        lexer.keyword("==", type: { _ in 2 } )
        XCTAssertEqual(["=="], try lexer.lex(input: "==").map({$0.word}))
    }

}

