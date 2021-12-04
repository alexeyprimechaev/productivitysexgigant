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

extension Bundle {
    static func load<T: Decodable>(_ filename: String) -> T {

        let readURL = Bundle.main.url(forResource: filename, withExtension: "json")! //Example json file in our bundle
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! // Initializing the url for the location where we store our data in filemanager

        let jsonURL = documentDirectory // appending the file name to the url
            .appendingPathComponent(filename)
            .appendingPathExtension("json")

        // The following condition copies the example file in our bundle to the correct location if it isnt present
        if !FileManager.default.fileExists(atPath: jsonURL.path) {
            try? FileManager.default.copyItem(at: readURL, to: jsonURL)
        }

        // returning the parsed data
        return try! JSONDecoder().decode(T.self, from: Data(contentsOf: jsonURL))
    }
}

class JsonData: ObservableObject {
    @Published var jsonArray: [TaskEntry] // The Published wrapper marks this value as a source of truth for the view

    init() {
        self.jsonArray = Bundle.load("list") // Initailizing the array from a json file
    }

    // function to write the json data into the file manager
    func writeJSON() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let jsonURL = documentDirectory
            .appendingPathComponent("list")
            .appendingPathExtension("json")
        try? JSONEncoder().encode(jsonArray).write(to: jsonURL, options: .atomic)
    }
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
