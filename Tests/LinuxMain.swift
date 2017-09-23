//
//  LexerTests.swift
//  Lexer
//
//  Created by Bernardo Breder.
//
//

import XCTest
@testable import LexerTests

extension LexerTests {

	static var allTests : [(String, (LexerTests) -> () throws -> Void)] {
		return [
			("test2Symbol", test2Symbol),
			("test", test),
		]
	}

}

XCTMain([
	testCase(LexerTests.allTests),
])

