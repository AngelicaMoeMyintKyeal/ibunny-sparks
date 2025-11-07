//
//  IdeasViewModel.swift
//  ibunny-sparks
//
//  Created by Htet Myat Moe Myint Kyeal on 07/11/25.
//

import Foundation
import SkipFuse
import SwiftUI

@Observable public class IdeaViewModel {
    var ideas: [Idea] = loadIdeas() {
        didSet { saveIdeas() }
    }
    
    init() {
        // Add some sample data if empty
        if ideas.isEmpty {
            ideas = [
                Idea(title: "Once Upon A Time in Wonderland", concept: "A modern retelling of Alice in Wonderland set in a cyberpunk universe.", date: Date().addingTimeInterval(-86400)),
                Idea(title: "The Kingdom of Broken Hearts", concept: "A fantasy romance about a queen who must mend literal broken hearts to save her kingdom.", date: Date().addingTimeInterval(-172800)),
                Idea(title: "Bunnies", concept: "A children's story about a group of bunnies who discover they have magical powers.", date: Date().addingTimeInterval(-259200)),
                Idea(title: "The Jade Rabbit", concept: "In the distant past, the myth of the Jade Rabbit was a symbol of sacrifice and immortality. This story reinterprets it in a world where the Moon holds the key to Earth's salvation.", date: Date().addingTimeInterval(-345600))
            ]
        }
    }
}

// MARK: - Persistence

extension IdeaViewModel {
    private static let savePath = URL.applicationSupportDirectory.appendingPathComponent("bunny-ideas.json")
    
    fileprivate static func loadIdeas() -> [Idea] {
        do {
            let data = try Data(contentsOf: savePath)
            return try JSONDecoder().decode([Idea].self, from: data)
        } catch {
            logger.warning("Failed to load ideas: \(error)")
            return []
        }
    }
    
    fileprivate func saveIdeas() {
        do {
            let data = try JSONEncoder().encode(ideas)
            try FileManager.default.createDirectory(at: URL.applicationSupportDirectory, withIntermediateDirectories: true)
            try data.write(to: Self.savePath)
        } catch {
            logger.error("Error saving ideas: \(error)")
        }
    }
}

// MARK: - Idea Data Model
struct Idea: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var concept: String
    var date: Date
    
    init(id: UUID = UUID(), title: String, concept: String, date: Date = Date()) {
        self.id = id
        self.title = title
        self.concept = concept
        self.date = date
    }
    
    var dateString: String {
        date.formatted(date: .long, time: .omitted)
    }
    
    var dateTimeString: String {
        date.formatted(date: .long, time: .shortened)
    }
    
    var image: Image {
        Image("idea-img-icon")
    }
}
