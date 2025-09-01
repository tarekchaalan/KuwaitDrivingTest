//
//  QuizModels.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import Foundation

struct QuizQuestion: Identifiable, Decodable, Hashable {
    let id: Int
    let text: String
    let answers: [String]
    let correctIndex: Int
    let imageName: String?
    let isCritical: Bool
            let tf: Bool // True/False question flag

    enum CodingKeys: String, CodingKey {
        case id, text, answers, correctIndex, imageName, isCritical
        case tf = "T/F"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        answers = try container.decode([String].self, forKey: .answers)
        correctIndex = try container.decode(Int.self, forKey: .correctIndex)
        imageName = try container.decodeIfPresent(String.self, forKey: .imageName)
        isCritical = try container.decode(Bool.self, forKey: .isCritical)

        // Try to decode from "T/F" first, then fallback to "tf"
        if let tfValue = try? container.decode(Bool.self, forKey: .tf) {
            tf = tfValue
        } else {
            // If "T/F" fails, try to decode from "tf" field
            let tfContainer = try decoder.container(keyedBy: TFCodingKeys.self)
            tf = try tfContainer.decode(Bool.self, forKey: .tf)
        }
    }

    private enum TFCodingKeys: String, CodingKey {
        case tf
    }
}

struct QuizResult: Equatable {
    let total: Int
    let correct: Int
    let passed: Bool
    let failedCritical: Bool
    let passingScore: Int
}

enum QuizState: Equatable {
    case idle
    case inProgress
    case finished(QuizResult)
}
