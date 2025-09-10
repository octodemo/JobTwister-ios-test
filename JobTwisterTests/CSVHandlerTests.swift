//
//  CSVHandlerTests.swift
//  JobTwisterTests
//
//  Created by GitHub Copilot
//

import Testing
import Foundation
@testable import JobTwister

struct CSVHandlerTests {

    @Test func testStringCSVEscaping() async throws {
        // Test CSV escaping for strings
        let simpleString = "Hello World"
        #expect(simpleString.escapingCSV() == "Hello World")
        
        let stringWithComma = "Hello, World"
        #expect(stringWithComma.escapingCSV() == "\"Hello, World\"")
        
        let stringWithQuotes = "Hello \"World\""
        #expect(stringWithQuotes.escapingCSV() == "\"Hello \"\"World\"\"\"")
        
        let stringWithNewline = "Hello\nWorld"
        #expect(stringWithNewline.escapingCSV() == "\"Hello\nWorld\"")
    }
    
    @Test func testStringCSVUnescaping() async throws {
        // Test CSV unescaping for strings
        let simpleString = "Hello World"
        #expect(simpleString.unescapingCSV() == "Hello World")
        
        let quotedString = "\"Hello, World\""
        #expect(quotedString.unescapingCSV() == "Hello, World")
        
        let doubleQuotedString = "\"Hello \"\"World\"\"\""
        #expect(doubleQuotedString.unescapingCSV() == "Hello \"World\"")
        
        let quotedNewlineString = "\"Hello\nWorld\""
        #expect(quotedNewlineString.unescapingCSV() == "Hello\nWorld")
    }
    
    @Test func testCSVEscapingRoundTrip() async throws {
        // Test that escaping and unescaping is reversible
        let testStrings = [
            "Simple string",
            "String, with comma",
            "String \"with quotes\"",
            "String\nwith\nnewlines",
            "Complex \"string\", with all, \"special\" characters\nand newlines"
        ]
        
        for original in testStrings {
            let escaped = original.escapingCSV()
            let unescaped = escaped.unescapingCSV()
            #expect(unescaped == original, "Round trip failed for: \(original)")
        }
    }
    
    @Test func testEmptyStringCSVHandling() async throws {
        // Test CSV handling for empty strings
        let emptyString = ""
        #expect(emptyString.escapingCSV() == "")
        #expect(emptyString.unescapingCSV() == "")
    }

}