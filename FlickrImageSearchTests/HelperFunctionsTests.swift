//
//  HelperFunctionsTests.swift
//  FlickrImageSearchTests
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import XCTest

class HelperFunctionsTests: XCTestCase {
    
    func testReadJSONFromFileForEmptyFileName() {
        HelperFunctions.shared.readJSONFromFile(fileName: "") { (result) in
            switch result {
            case .success(_):
                XCTFail("This test shouldn't return success")
            case let .failure(error):
                XCTAssert(error is ReadJSONError)
            }
        }
    }
    
    func testReadJSONFromFileForNonEmptyInvalidFileName() {
        HelperFunctions.shared.readJSONFromFile(fileName: "kuchbhi") { (result) in
            switch result {
            case .success(_):
                XCTFail("This test shouldn't return success")
            case let .failure(error):
                XCTAssert(error is ReadJSONError)
            }
        }
    }
    
    func testReadJSONFromFileForValidPath() {
        HelperFunctions.shared.readJSONFromFile(fileName: "FoodImageSearchResponseMock") { result in
            switch result {
            case let .success(data):
                XCTAssertNotNil(data)
            case .failure(_):
                XCTFail("This test shouldn't fail")
            }
        }
    }
}
