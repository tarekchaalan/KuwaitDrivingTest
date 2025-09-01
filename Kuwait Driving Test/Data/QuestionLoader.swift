//
//  QuestionLoader.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import Foundation

enum QuestionLoader {
    static func load() -> [QuizQuestion] {
        guard let url = Bundle.main.url(forResource: "Questions", withExtension: "json") else {
            assertionFailure("Questions.json missing in bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([QuizQuestion].self, from: data)
        } catch {
            assertionFailure("Failed to decode Questions.json: \(error)")
            return []
        }
    }
}
