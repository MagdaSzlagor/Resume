//
//  ResumeDetailsInteractorTests.swift
//  ResumeTests
//
//  Created by Magdalena Szlagor on 18/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import XCTest
@testable import Resume

class ResumeDetailsInteractorTests: XCTestCase {

    class MockResumeDetailsWorker: ResumeDetailsWorker {
        
        var result: Result<Resume>?
        
        override func fetchResumeDetails(onSuccess: @escaping ((Resume) -> Void), onError: @escaping ((NetworkingError) -> Void)) {
            guard let result = result else {
                XCTFail("Did not supply fake result in MockResumeDetailsWorker")
                return
            }
            switch result {
            case .success(let resume):
                onSuccess(resume)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    var interactor: ResumeDetailsInteractor!
    var worker: MockResumeDetailsWorker!
    let resumeStub = Resume(email: "test@test.com", name: "Name", surname: "Surname", phoneNumber: "123456789", profileImage: nil, summary: "Summary", experience: [Experience(startDateString: "01-10-2007", endDateString: "01-10-2012", employer: "Employer", position: "Position", info: "Desc", address: "Address")], education: [Education(startDateString: "01-10-2007", endDateString: "01-10-2012", university: "Univrsity", info: "Desc", title: "Uni Title")])
    
    override func setUp() {
        super.setUp()
        worker = MockResumeDetailsWorker()
        interactor = ResumeDetailsInteractor()
        interactor.worker = worker
    }
    
    override func tearDown() {
        worker = nil
        interactor = nil
        super.tearDown()
    }
    
    func testFetchResumeDetailsSuccess() {
        fetchResumeDetailsWithSuccess()
        guard let resume = interactor.resume else {
            XCTFail("Nil Resume Returned")
            return
        }
        XCTAssertEqual(resume, resumeStub)
    }
    
    func testFetchResumeDetailsFailed() {
        fetchResumeDetailsWithError()
        XCTAssertNil(interactor.resume)
    }

    private func fetchResumeDetailsWithSuccess() {
        worker.result = Result.success(resumeStub)
        interactor.fetchResumeDetails()
    }
    
    private func fetchResumeDetailsWithError() {
        worker.result = Result.failure(NetworkingError.noInternetConnection)
        interactor.fetchResumeDetails()
    }
}
