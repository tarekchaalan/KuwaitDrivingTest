//
//  Kuwait_Driving_TestTests.swift
//  Kuwait Driving TestTests
//
//  Created by Tarek Chaalan on 8/31/25.
//

import Testing
@testable import Kuwait_Driving_Test

struct Kuwait_Driving_TestTests {
    @Test func testQuestionsLoad() async throws {
        let qs = QuestionLoader.load()
        #expect(qs.count == 170)
        #expect(qs.contains { $0.isCritical })
        #expect(qs.contains { $0.imageName == "Ambulance" })
    }
}
