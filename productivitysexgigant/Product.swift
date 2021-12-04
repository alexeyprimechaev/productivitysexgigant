//
//  PortfolioPoint.swift
//  Portfolio (iOS)
//
//  Created by Alexey Primechaev on 10/9/21.
//

import Foundation

struct TaskEntry: Identifiable, Codable {
    
    var id: Int
    
    let title: String
    var timeStarted: Date
    var timeFinished: Date
    var time: Int
    var isInProgress: Bool
    var isSuccesful: Bool
}


enum APIService {
    static func fetch<T: Decodable>(from url: URL) async throws -> [T] {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let result = try decoder.decode([T].self, from: data)
        
        return result
    }
    
    static func fetchTaskEntries(urlString: String) async throws -> [TaskEntry] {
        guard let url = URL(string: urlString) else {
            return []
        }
        
        return try await APIService
            .fetch(from: url)
    }
    
    
}
