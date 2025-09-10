//
//  InterviewTests.swift
//  JobTwisterTests
//
//  Created by GitHub Copilot
//

import Testing
import Foundation
@testable import JobTwister

struct InterviewTests {

    @Test func testInterviewCreation() async throws {
        // Test interview creation with default values
        let interview = Interview()
        
        #expect(!interview.id.isEmpty)
        #expect(interview.notes.isEmpty)
        // Date should be set to current time (within reasonable range)
        #expect(abs(interview.date.timeIntervalSinceNow) < 1.0)
    }
    
    @Test func testInterviewCreationWithDate() async throws {
        // Test interview creation with specific date
        let testDate = Date(timeIntervalSince1970: 1704067200) // Jan 1, 2024
        let interview = Interview(date: testDate)
        
        #expect(!interview.id.isEmpty)
        #expect(interview.date == testDate)
        #expect(interview.notes.isEmpty)
    }
    
    @Test func testInterviewUniqueIds() async throws {
        // Test that each interview gets a unique ID
        let interview1 = Interview()
        let interview2 = Interview()
        
        #expect(interview1.id != interview2.id)
    }
    
    @Test func testInterviewNotesModification() async throws {
        // Test interview notes can be modified
        let interview = Interview()
        #expect(interview.notes.isEmpty)
        
        interview.notes = "Initial phone screening went well"
        #expect(interview.notes == "Initial phone screening went well")
        
        interview.notes = "Technical interview scheduled for next week"
        #expect(interview.notes == "Technical interview scheduled for next week")
    }

}