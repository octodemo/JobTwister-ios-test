//
//  JobMigrationTests.swift
//  JobTwisterTests
//
//  Created by GitHub Copilot
//

import Testing
import Foundation
@testable import JobTwister

struct JobMigrationTests {

    @Test func testMigrateOldInterviewData() async throws {
        // Test migration of old interview data
        let testDate = Date()
        let job = Job()
        
        // Set up old interview data
        job.hasInterview = true
        job.interviewDate = testDate
        job.interviews = [] // Start with empty interviews
        
        // Perform migration
        job.migrateOldInterviewData()
        
        // Check migration results
        #expect(job.interviews.count == 1)
        #expect(job.interviews.first?.date == testDate)
        #expect(!job.hasInterview) // Old flag should be cleared
        #expect(job.interviewDate == nil) // Old date should be cleared
    }
    
    @Test func testMigrationSkippedWhenNoOldData() async throws {
        // Test that migration is skipped when there's no old data
        let job = Job()
        job.hasInterview = false
        job.interviewDate = nil
        
        job.migrateOldInterviewData()
        
        #expect(job.interviews.isEmpty)
        #expect(!job.hasInterview)
        #expect(job.interviewDate == nil)
    }
    
    @Test func testMigrationSkippedWhenInterviewsExist() async throws {
        // Test that migration is skipped when interviews already exist
        let job = Job()
        let existingInterview = Interview()
        job.interviews = [existingInterview]
        
        // Set old data
        job.hasInterview = true
        job.interviewDate = Date()
        
        job.migrateOldInterviewData()
        
        // Should not add another interview
        #expect(job.interviews.count == 1)
        #expect(job.interviews.first === existingInterview)
        #expect(job.hasInterview) // Old data should remain
    }
    
    @Test func testHasAnyInterviewProperty() async throws {
        // Test hasAnyInterview computed property
        let job = Job()
        #expect(!job.hasAnyInterview)
        
        let interview = Interview()
        job.interviews = [interview]
        #expect(job.hasAnyInterview)
        
        job.interviews = []
        #expect(!job.hasAnyInterview)
    }
    
    @Test func testLatestInterviewDate() async throws {
        // Test latestInterviewDate computed property
        let job = Job()
        #expect(job.latestInterviewDate == nil)
        
        let date1 = Date(timeIntervalSince1970: 1704067200) // Jan 1, 2024
        let date2 = Date(timeIntervalSince1970: 1704153600) // Jan 2, 2024
        let date3 = Date(timeIntervalSince1970: 1704240000) // Jan 3, 2024
        
        let interview1 = Interview(date: date1)
        let interview2 = Interview(date: date3) // Latest
        let interview3 = Interview(date: date2)
        
        job.interviews = [interview1, interview2, interview3]
        
        #expect(job.latestInterviewDate == date3)
    }

}