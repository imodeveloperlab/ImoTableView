//
//  ImoTableViewTests.swift
//  ImoTableViewTests
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import ImoTableView

class ImoTableViewTests: QuickSpec {
    
    override func spec() {
        
        context("Sections") {
            
            let table = tableView()
            
            it("no sections") {
                
                let sectionsCount = table.numberOfSections(in: table.tableView)
                expect(sectionsCount).to(equal(0))
            }
            
            it("add one section") {
                
                let section = ImoTableViewSection()
                table.add(section: section)
                let sectionsCount = table.numberOfSections(in: table.tableView)
                expect(sectionsCount).to(equal(1))
            }
            
            it("add multiple sections") {
                
                let sectionA = ImoTableViewSection()
                let sectionB = ImoTableViewSection()
                let sectionC = ImoTableViewSection()
                let sectionD = ImoTableViewSection()
                table.add(sections:[sectionA, sectionB, sectionC, sectionD])
                let sectionsCount = table.numberOfSections(in: table.tableView)
                expect(sectionsCount).to(equal(5))
            }
            
            it("number of rows in section") {
                
                let table = tableView()
                let section = ImoTableViewSection()
                
                let cellSource = TestCellSource()
                section.add(cellSource)
                
                let cellSourceA = TestACellSource()
                section.add(cellSourceA)
                
                table.add(section: section)
                
                let count = table.tableView(table.tableView, numberOfRowsInSection: 0)
                expect(count).to(equal(2))
            }
            
            it("get index set") {
                
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
                
                expect(indexSet.contains(0)).to(beTrue())
                expect(indexSet.contains(2)).to(beTrue())
                expect(indexSet.contains(4)).to(beTrue())
            }
        }
        
        context("Select row") {
            
            it("at index path") {
                
                let expect = self.expectation(description: "Expect")
                let table = tableView()
                let sectionA = ImoTableViewSection()
                let cellSource = TestCellSource()
                sectionA.add(cellSource)
                table.add(section: sectionA)
                
                table.didSelectCellAtIndexPath = { indexPath in
                    Nimble.expect(indexPath.row).to(equal(0))
                    expect.fulfill()
                }
                
                table.tableView(table.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                
                self.waitForExpectations(timeout: 1) { (error) in
                    if let error = error {
                        XCTFail("Error: \(error.localizedDescription)")
                    }
                }
            }
            
            it("source") {
                
                let expect = self.expectation(description: "Expect")
                let table = tableView()
                let sectionA = ImoTableViewSection()
                let cellSource = TestCellSource()
                cellSource.height = 55
                sectionA.add(cellSource)
                table.add(section: sectionA)
                
                table.didSelectSource = { source in
                    Nimble.expect(cellSource.height).to(equal(55))
                    expect.fulfill()
                }
                
                table.tableView(table.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                
                self.waitForExpectations(timeout: 1) { (error) in
                    if let error = error {
                        XCTFail("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
        
        context("Cells") {
            
            it("for row at index path") {
                
                let table = tableView()
                let section = ImoTableViewSection()
                
                let cellSource = TestCellSource()
                section.add(cellSource)
                
                let cellSourceA = TestACellSource()
                section.add(cellSourceA)
                
                table.add(section: section)
                table.update()
                
                let cell = table.tableView.cellForRow(at: IndexPath(row: 1, section: 0))
                expect(cell?.isKind(of: TestACell.classForCoder())).to(beTrue())
            }
            
            it("source for row at index path") {
                
                let table = tableView()
                let section = ImoTableViewSection()
                
                let cellSource = TestCellSource()
                section.add(cellSource)
                
                let cellSourceA = TestACellSource()
                section.add(cellSourceA)
                
                table.add(section: section)
                let source = table.cellSourceForIndexPath(indexPath: IndexPath(row: 1, section: 0))
                expect(source?.isKind(of: TestACellSource.classForCoder())).to(beTrue())
            }
            
            it("multiple registered cells") {
                
                let table = tableView()
                let section = ImoTableViewSection()
                
                let cellSource = TestCellSource()
                section.add(cellSource)
                
                let cellSourceA = TestACellSource()
                section.add(cellSourceA)
                
                table.add(section: section)
                table.update()
                
                _ = table.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                expect(table.registeredCells.count).to(equal(2))
            }
            
            it("one registered cells") {
                
                let table = tableView()
                let section = ImoTableViewSection()
                
                let cellSource = TestCellSource()
                section.add(cellSource)
                
                table.add(section: section)
                table.update()
                
                _ = table.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                expect(table.registeredCells.count).to(equal(1))
            }
        }
        
        context("Rows") {
            
            it("has correct height") {
                
                let table = tableView()
                let section = ImoTableViewSection()
                
                let cellSource = TestCellSource()
                cellSource.height = 200
                section.add(cellSource)
                table.add(section: section)
                table.update()
                
                let height = table.tableView(table.tableView, heightForRowAt: IndexPath(row: 0, section: 0))
                expect(height).to(equal(200))
            }
            
            it("has correct estimated height") {
                
                let table = tableView()
                let section = ImoTableViewSection()
                table.estimatedHeightForRow = 15
                
                let cellSource = TestCellSource()
                cellSource.estimatedHeightForRow = 15
                section.add(cellSource)
                
                table.add(section: section)
                table.update()
                
                let estimated = table.tableView(table.tableView, estimatedHeightForRowAt: IndexPath(row: 0, section: 0))
                expect(estimated).to(equal(15))
            }
        }
    }
}
