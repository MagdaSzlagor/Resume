//
//  ResumeDetailsPresenterTests.swift
//  ResumeTests
//
//  Created by Magdalena Szlagor on 18/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import XCTest
@testable import Resume

class ResumeDetailsPresenterTests: XCTestCase {
    
    var resumeDetailsPresenter: ResumeDetailsPresenter!

    class MockResumeDisplayLogic: ResumeDetailsDisplayLogic {
        var shouldShowNoResumeError = false
        var shouldShowResumeDetails = false
        
        func displayResume(viewModel: ResumeDetails.FetchResumeDetails.ViewModel) {
            shouldShowResumeDetails = true
        }
        
        func displayError(message: String) {
            shouldShowNoResumeError = true
        }
    }
    
    var mockViewController: MockResumeDisplayLogic!
    
    override func setUp() {
        super.setUp()
        mockViewController = MockResumeDisplayLogic()
        resumeDetailsPresenter = ResumeDetailsPresenter()
        resumeDetailsPresenter.viewController = mockViewController
    }
    
    override func tearDown() {
        mockViewController = nil
        resumeDetailsPresenter = nil
        super.tearDown()
    }
    
    func testViewControllerShowErrorWhenNoResume() {
        resumeDetailsPresenter.presentError(message: "")
        XCTAssertEqual(mockViewController.shouldShowNoResumeError, true)
        XCTAssertEqual(mockViewController.shouldShowResumeDetails, false)
    }
    
    func testViewControllerShowResumeWhenSuccess() {
        let experience = Experience(startDateString: "01-10-2007", endDateString: "01-10-2012", employer: "Employer", position: "Position", info: "Desc", address: "Address")
        let education = Education(startDateString: "01-10-2007", endDateString: "01-10-2012", university: "Univrsity", info: "Desc", title: "Uni Title")
        let resume = Resume(email: "test@test.com", name: "Name", surname: "Surname", phoneNumber: "123456789", profileImage: nil, summary: "Summar", experience: [experience], education: [education])
        resumeDetailsPresenter.presentResumeDetails(resume)
        XCTAssertEqual(mockViewController.shouldShowNoResumeError, false)
        XCTAssertEqual(mockViewController.shouldShowResumeDetails, true)
    }
}
