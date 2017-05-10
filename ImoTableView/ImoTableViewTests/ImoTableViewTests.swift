//
//  ImoTableViewTests.swift
//  ImoTableViewTests
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import XCTest
@testable import ImoTableView

class ImoTableViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitTablePerformance() {

        self.measure {

            let table = tableView()
            _ = table.numberOfSections(in: table.tableView)
        }
    }
    
    func testInitTable() {
    
        let table = tableView()
        let sectionsCount = table.numberOfSections(in: table.tableView)
        XCTAssertTrue(sectionsCount == 0)
        
    }
    
    func testTableAddSection() {
        
        let table = tableView()
        
        let section = ImoTableViewSection()
        table.add(section: section)
        
        let sectionsCount = table.numberOfSections(in: table.tableView)
        XCTAssertTrue(sectionsCount == 1)
        
    }
    
    func testTableAddMultipleSections() {
        
        let table = tableView()
        
        let sectionA = ImoTableViewSection()
        let sectionB = ImoTableViewSection()
        let sectionC = ImoTableViewSection()
        let sectionD = ImoTableViewSection()
        
        table.add(sections:[sectionA, sectionB, sectionC, sectionD])
        
        let sectionsCount = table.numberOfSections(in: table.tableView)
        XCTAssertTrue(sectionsCount == 4)
        
    }
    
    func testTableSelectRowAtIndexPath() {
        
        let expect = expectation(description: "Expect")
        
        let table = tableView()
        let sectionA = ImoTableViewSection()
        let cellSource = TestCellSource()
        sectionA.add(cellSource)
        table.add(section: sectionA)
        
        table.didSelectCellAtIndexPath = { indexPath in
            
            XCTAssertTrue(indexPath.row == 0)
            expect.fulfill()
        }
        
        table.tableView(table.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testTableDidSelectSource() {
        
        let expect = expectation(description: "Expect")
        
        let table = tableView()
        let sectionA = ImoTableViewSection()
        let cellSource = TestCellSource()
        cellSource.height = 55
        sectionA.add(cellSource)
        table.add(section: sectionA)
        
        table.didSelectSource = { source in
            
            XCTAssertEqual(cellSource.height, 55)
            expect.fulfill()
        }
        
        table.tableView(table.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testRegisteredCells() {
        
        let table = tableView()
        let section = ImoTableViewSection()
        
        let cellSource = TestCellSource()
        section.add(cellSource)
        
        let cellSourceA = TestACellSource()
        section.add(cellSourceA)
        
        table.add(section: section)
        table.update()
        
        let _ = table.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(table.registeredCells.count, 2)
    }
    
    func testOneRegisteredCell() {
        
        let table = tableView()
        let section = ImoTableViewSection()
        
        let cellSource = TestCellSource()
        section.add(cellSource)
        
        table.add(section: section)
        table.update()
        
        let _ = table.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(table.registeredCells.count, 1)
    }
    
    func testCellForRowAtIndexPath() {
        
        let table = tableView()
        let section = ImoTableViewSection()
        
        let cellSource = TestCellSource()
        section.add(cellSource)
        
        let cellSourceA = TestACellSource()
        section.add(cellSourceA)
        
        table.add(section: section)
        table.update()
        
        let cell = table.tableView.cellForRow(at: IndexPath(row: 1, section: 0))
        
        XCTAssertTrue(cell!.isKind(of: TestACell.classForCoder()))
    }
    
    func testCellSourceForIndexPath() {
        
        let table = tableView()
        let section = ImoTableViewSection()
        
        let cellSource = TestCellSource()
        section.add(cellSource)
        
        let cellSourceA = TestACellSource()
        section.add(cellSourceA)
        
        table.add(section: section)
        let source = table.cellSourceForIndexPath(indexPath: IndexPath(row: 1, section: 0))
        
        XCTAssertTrue(source!.isKind(of: TestACellSource.classForCoder()))
    }
    
    func testNumberOfRowsInSectionh() {
        
        let table = tableView()
        let section = ImoTableViewSection()
        
        let cellSource = TestCellSource()
        section.add(cellSource)
        
        let cellSourceA = TestACellSource()
        section.add(cellSourceA)
        
        table.add(section: section)
        
        let count = table.tableView(table.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(count, 2)
    }
    
    func testHeightForRowAt() {
        
        let table = tableView()
        let section = ImoTableViewSection()
        
        let cellSource = TestCellSource()
        cellSource.height = 200
        section.add(cellSource)
        
        table.add(section: section)
        
        table.update()
        
        let height = table.tableView(table.tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(height, 200)
    }
    
    func testEstimatedHeightForRow() {
        
        let table = tableView()
        table.estimatedHeightForRow = 15
        let estimated = table.tableView(table.tableView, estimatedHeightForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(estimated, 15)
    }
    
    func testIndexSetForSections() {
        
        let table = tableView()
        
        let sectionA = ImoTableViewSection()
        let sectionB = ImoTableViewSection()
        let sectionC = ImoTableViewSection()
        let sectionD = ImoTableViewSection()
        let sectionE = ImoTableViewSection()
        
        table.add(section: sectionA)
        table.add(section: sectionB)
        table.add(section: sectionC)
        table.add(section: sectionD)
        table.add(section: sectionE)
        
        let indexSet = table.indexSetForSections(sections: [sectionA, sectionC, sectionE])
        
        XCTAssertTrue(indexSet.contains(0))
        XCTAssertTrue(indexSet.contains(2))
        XCTAssertTrue(indexSet.contains(4))
    }
}
