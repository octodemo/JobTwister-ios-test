//
//  JobTwisterTests.swift
//  JobTwisterTests
//
//  Created by Thomas McMahon on 6/25/25.
//

import Testing
import Foundation
@testable import JobTwister

struct JobTwisterTests {

    @Test func testJobCreation() async throws {
        // Test job creation with default values
        let job = Job()
        
        #expect(!job.id.isEmpty)
        #expect(job.companyName.isEmpty)
        #expect(job.jobTitle.isEmpty)
        #expect(job.workplaceType == .remote)
        #expect(!job.isDenied)
        #expect(job.interviews.isEmpty)
        #expect(job.notes.isEmpty)
    }
    
    @Test func testJobCreationWithParameters() async throws {
        // Test job creation with specific parameters
        let testDate = Date()
        let testURL = URL(string: "https://example.com/job")
        
        let job = Job(
            dateApplied: testDate,
            companyName: "Test Company",
            jobTitle: "iOS Developer",
            url: testURL,
            salaryMin: 100000,
            salaryMax: 150000,
            workplaceType: .hybrid,
            notes: "Test notes"
        )
        
        #expect(job.dateApplied == testDate)
        #expect(job.companyName == "Test Company")
        #expect(job.jobTitle == "iOS Developer")
        #expect(job.url == testURL)
        #expect(job.salaryMin == 100000)
        #expect(job.salaryMax == 150000)
        #expect(job.workplaceType == .hybrid)
        #expect(job.notes == "Test notes")
    }
    
    @Test func testWorkplaceTypeEnum() async throws {
        // Test WorkplaceType enum values
        #expect(WorkplaceType.remote.rawValue == "Remote")
        #expect(WorkplaceType.hybrid.rawValue == "Hybrid")
        #expect(WorkplaceType.inOffice.rawValue == "In-Office")
    }
    
    @Test func testJobInterviewMigration() async throws {
        // Test legacy interview data migration
        let testDate = Date()
        let job = Job(
            hasInterview: true,
            interviewDate: testDate
        )
        
        // Check that legacy interview data was migrated
        #expect(job.interviews.count == 1)
        #expect(job.interviews.first?.date == testDate)
    }
    
    @Test func testJobDenialFunctionality() async throws {
        // Test job denial functionality
        let job = Job()
        #expect(!job.isDenied)
        #expect(job.deniedDate == nil)
        
        // Test setting denial status
        let denialDate = Date()
        job.isDenied = true
        job.deniedDate = denialDate
        
        #expect(job.isDenied)
        #expect(job.deniedDate == denialDate)
    }
    
    @Test func testJobLastModifiedUpdate() async throws {
        // Test that lastModified is set on creation
        let job = Job()
        let creationTime = job.lastModified
        
        // Small delay to ensure time difference
        try await Task.sleep(nanoseconds: 1_000_000) // 1ms
        
        // Update job and check lastModified changes
        job.companyName = "Updated Company"
        job.lastModified = Date()
        
        #expect(job.lastModified > creationTime)
    }

}
