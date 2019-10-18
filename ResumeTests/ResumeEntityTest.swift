//
//  ResumeEntityTest.swift
//  ResumeTests
//
//  Created by Magdalena Szlagor on 18/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import XCTest
@testable import Resume

// same for Education & Experience entities
class ResumeEntityTest: XCTestCase {
    
    var resume: Resume!
    
    override func setUp() {
        super.setUp()
        
        let experience = Experience(startDateString: "01-10-2007", endDateString: "01-10-2012", employer: "Employer", position: "Position", info: "Desc", address: "Address")
        let education = Education(startDateString: "01-10-2007", endDateString: "01-10-2012", university: "Univrsity", info: "Desc", title: "Uni Title")
        resume = Resume(email: "test@test.com", name: "Name", surname: "Surname", phoneNumber: "123456789", profileImage: nil, summary: "Summary", experience: [experience], education: [education])
    }
    
    override func tearDown() {
        resume = nil
        super.tearDown()
    }

    func testResumeSetGet() {
        XCTAssertEqual(resume.email, "test@test.com")
        XCTAssertEqual(resume.name, "Name")
        XCTAssertEqual(resume.surname, "Surname")
        XCTAssertEqual(resume.phoneNumber, "123456789")
        XCTAssertEqual(resume.summary, "Summary")
        XCTAssertEqual(resume.experience?.count, 1)
        XCTAssertNil(resume.profileImage)
    }
}
