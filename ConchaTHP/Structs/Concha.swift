//
//  Concha.swift
//  ConchaTHP
//
//  Created by Shanezzar Sharon on 28/03/2022.
//

import Foundation

struct Concha: Codable, Equatable {
    
    // MARK: - Variables
    
    let complete: String?
    let sessionID: Int
    let stepCount: Int?
    let ticks: [Int]?

    enum CodingKeys: String, CodingKey {
        case complete = "complete"
        case sessionID = "session_id"
        case stepCount = "step_count"
        case ticks = "ticks"
    }
}

extension Concha {
    
    // MARK: - Properties
    
    static let empty = Concha(complete: nil, sessionID: 0, stepCount: nil, ticks: nil)
}
