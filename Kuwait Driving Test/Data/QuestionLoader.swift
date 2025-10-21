//
//  QuestionLoader.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import Foundation

enum QuestionLoader {
    static func load() -> [QuizQuestion] {
        load(arabic: false)
    }

    static func load(arabic: Bool) -> [QuizQuestion] {
        let resource = arabic ? "Questions.ar" : "Questions"
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json") else {
            assertionFailure("\(resource).json missing in bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([QuizQuestion].self, from: data)
        } catch {
            assertionFailure("Failed to decode \(resource).json: \(error)")
            return []
        }
    }
}
