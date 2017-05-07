//
//  ImoTableViewSectionTests.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 5/6/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import XCTest
@testable import ImoTableView

class ImoTableViewSectionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func someMethod() {
        
    }
    
    func testAddSources() {
        
        let section = ImoTableViewSection()
        let sourceA = TestCellSource()
        let sourceB = TestCellSource()
        
        section.add(sourceA)
        section.add(sourceB)
        
        XCTAssertEqual(section.count(), 2)
    }
    
    func testAddSourcesWithTargets() {
        
        let section = ImoTableViewSection()
        let sourceA = TestCellSource()
        let sourceB = TestCellSource()
        let sourceC = TestCellSource()
        
        section.add(sourceA, target: self, #selector(someMethod))
        section.add(sourceB, target: self, #selector(someMethod))
        section.add(sourceC, target: self, #selector(someMethod))
        
        XCTAssertEqual(section.count(), 3)
    }
    
    func testAddArrayOfSourcesWithTargets() {
        
        let section = ImoTableViewSection()
        let sourceA = TestCellSource()
        let sourceB = TestCellSource()
        let sourceC = TestCellSource()
        
        section.add(sources: [sourceA, sourceB, sourceC], target: self, #selector(someMethod))
        
        XCTAssertEqual(section.count(), 3)
    }
    
    func testGetSource() {
        
        let section = ImoTableViewSection()
        let sourceA = TestCellSource()
        let sourceB = TestACellSource()
        let sourceC = TestCellSource()
        
        section.add(sources: [sourceA, sourceB, sourceC])
        let source = section.get(sourceAtIndex: 1)
        
        XCTAssertTrue(source!.isKind(of: TestACellSource.classForCoder()))
    }
    
    func testDeleteSource() {
        
        let section = ImoTableViewSection()
        let sourceA = TestCellSource()
        let sourceB = TestACellSource()
        let sourceC = TestCellSource()
        section.add(sources: [sourceA, sourceB, sourceC])

        do {
            try section.delete(sourceB)
        } catch { print(error) }
        
        XCTAssertEqual(section.count(), 2)
    }
    
    func testDeleteAll() {
        
        let section = ImoTableViewSection()
        let sourceA = TestCellSource()
        let sourceB = TestACellSource()
        let sourceC = TestCellSource()
        section.add(sources: [sourceA, sourceB, sourceC])
        XCTAssertEqual(section.count(), 3)
        section.deleteAll()
        XCTAssertEqual(section.count(), 0)
    }
    
    func testIndexOfSource() {
        
        let section = ImoTableViewSection()
        let sourceA = TestCellSource()
        let sourceB = TestACellSource()
        let sourceC = TestCellSource()
        section.add(sources: [sourceA, sourceB, sourceC])
        XCTAssertEqual(section.count(), 3)
        
        var index: Int = 0
        
        do {
            index = try section.indexOfSource(source: sourceC)
        } catch { print(error) }
        
        XCTAssertEqual(index, 2)
    }
}
