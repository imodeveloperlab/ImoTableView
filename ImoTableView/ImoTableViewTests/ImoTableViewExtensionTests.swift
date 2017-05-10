//
//  ImoTableViewExtensionTests.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 5/10/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import XCTest
@testable import ImoTableView

class ImoTableViewExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKeyboadIntersection() {
        
        let expect = expectation(description: "Expect")
        
        let controller = TestViewControllerKeyboardIntersection()
        
        controller.table.shouldAdjustScrollForKeyboard(adjust: true)
        controller.textField.becomeFirstResponder()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expect.fulfill()
        }
        
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
}


