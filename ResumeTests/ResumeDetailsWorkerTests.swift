//
//  ResumeDetailsWorkerTests.swift
//  ResumeTests
//
//  Created by Magdalena Szlagor on 18/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import XCTest
@testable import Resume

class ResumeDetailsWorkerTests: XCTestCase {
    
     var resumeDetailsWorker: ResumeDetailsWorker!

    override func setUp() {
        super.setUp()
        resumeDetailsWorker = ResumeDetailsWorker()
    }

    override func tearDown() {
        resumeDetailsWorker = nil
        super.tearDown()
    }

    func testFetchResumeDetails() {
        let promise = expectation(description: "Get Resume object")
        var resume: Resume?
        var responseError: NetworkingError?
        
        resumeDetailsWorker.fetchResumeDetails(onSuccess: { (result) in
            resume = result
            promise.fulfill()
        }) { (error) in
            responseError = error
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(resume)
    }
}
