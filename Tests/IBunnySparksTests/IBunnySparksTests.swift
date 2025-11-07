//
//  IBunnySparksTests.swift
//  ibunny-sparks
//
//  Created by Htet Myat Moe Myint Kyeal on 07/11/25.
//

import XCTest
import SkipFuse
@testable import IBunnySparks

final class IBunnySparksTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        print("=== Starting test: \(self.name) ===")
    }
    
    override func tearDown() {
        super.tearDown()
        print("=== Finished test: \(self.name) ===")
    }
    
    func testIdeaCreation() {
        print("Testing idea creation...")
        let idea = Idea(title: "Test Idea", concept: "Test Concept", date: Date())
        
        XCTAssertEqual(idea.title, "Test Idea", "Idea title should match")
        XCTAssertEqual(idea.concept, "Test Concept", "Idea concept should match")
        XCTAssertFalse(idea.id.uuidString.isEmpty, "Idea should have a non-empty UUID")
        
        print("✅ Idea created successfully: \(idea.title)")
    }
    
    func testIdeaDateFormatting() {
        print("Testing date formatting...")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let testDate = dateFormatter.date(from: "2023/12/03 09:41")!
        
        let idea = Idea(title: "Test", concept: "Test", date: testDate)
        
        XCTAssertTrue(idea.dateString.contains("December"), "Date string should contain month name")
        XCTAssertTrue(idea.dateTimeString.contains("9:41"), "DateTime string should contain time")
        
        print("✅ Date formatting correct: \(idea.dateString)")
        print("✅ DateTime formatting correct: \(idea.dateTimeString)")
    }
    
    func testViewModelAddIdea() {
        print("Testing view model add functionality...")
        let viewModel = IdeaViewModel()
        let initialCount = viewModel.ideas.count
        
        let newIdea = Idea(title: "New Idea", concept: "New Concept")
        viewModel.ideas.insert(newIdea, at: 0)
        
        XCTAssertEqual(viewModel.ideas.count, initialCount + 1, "Ideas count should increase by 1")
        XCTAssertEqual(viewModel.ideas.first?.title, "New Idea", "New idea should be at the top")
        
        print("✅ ViewModel add test passed. Count: \(initialCount) → \(viewModel.ideas.count)")
    }
    
    func testViewModelDeleteIdea() {
        print("Testing view model delete functionality...")
        let viewModel = IdeaViewModel()
        
        // Ensure we have at least one idea to delete
        if viewModel.ideas.isEmpty {
            let sampleIdea = Idea(title: "Sample", concept: "Sample")
            viewModel.ideas.append(sampleIdea)
        }
        
        let initialCount = viewModel.ideas.count
        let ideaToDelete = viewModel.ideas[0]
        
        viewModel.ideas.removeAll { $0.id == ideaToDelete.id }
        
        XCTAssertEqual(viewModel.ideas.count, initialCount - 1, "Ideas count should decrease by 1")
        XCTAssertFalse(viewModel.ideas.contains(where: { $0.id == ideaToDelete.id }),
                      "Deleted idea should not be in the array")
        
        print("✅ ViewModel delete test passed. Count: \(initialCount) → \(viewModel.ideas.count)")
    }
    
    func testEmptyViewModel() {
        print("Testing empty view model scenario...")
        let viewModel = IdeaViewModel()
        
        // Clear all ideas for this test
        viewModel.ideas.removeAll()
        
        XCTAssertTrue(viewModel.ideas.isEmpty, "ViewModel should be empty after clearing")
        print("✅ Empty view model test passed")
    }
    
    func testIdeaPersistence() {
        print("Testing idea persistence...")
        let testIdea = Idea(title: "Persistence Test", concept: "Testing if ideas can be encoded/decoded")
        
        do {
            // Test encoding
            let encoder = JSONEncoder()
            let data = try encoder.encode(testIdea)
            
            // Test decoding
            let decoder = JSONDecoder()
            let decodedIdea = try decoder.decode(Idea.self, from: data)
            
            XCTAssertEqual(testIdea.title, decodedIdea.title, "Encoded/decoded title should match")
            XCTAssertEqual(testIdea.concept, decodedIdea.concept, "Encoded/decoded concept should match")
            
            print("✅ Idea persistence test passed")
        } catch {
            XCTFail("Persistence test failed with error: \(error)")
        }
    }
    
    func testPerformanceExample() {
        print("Testing performance...")
        measure {
            // Measure the time of creating 100 ideas
            var ideas: [Idea] = []
            for i in 0..<100 {
                let idea = Idea(title: "Idea \(i)", concept: "Concept \(i)")
                ideas.append(idea)
            }
            _ = ideas.count // Ensure the work isn't optimized away
        }
        print("✅ Performance test completed")
    }
    
    func testSkipModule() throws {
        // This test verifies the Skip module is properly configured
        print("Testing Skip module configuration...")
        
        // Test that our main types can be instantiated
        let idea = Idea(title: "Skip Test", concept: "Testing Skip module")
        XCTAssertEqual(idea.title, "Skip Test")
        
        let viewModel = IdeaViewModel()
        XCTAssertNotNil(viewModel)
        
        print("✅ Skip module test passed")
    }
}
