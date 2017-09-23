//
//  Token.swift
//  Language
//
//  Created by Bernardo Breder on 18/01/17.
//
//

import Foundation

public struct Token {
    
    public let word: String
    
    public let type: Int
    
    public let line: Int
    
    public let column: Int
    
}

public enum TokenType: Int {
    
    case number
    case string
    case identifier
    case comment
    case symbol
    
}
