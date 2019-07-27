//
//  SearchResponseDeserializationTests.swift
//  FlickrImageSearchTests
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

@testable import FlickrImageSearch
import XCTest

class SearchResponseDeserializationTests: XCTestCase {
    
    let decoder = JSONDecoder()
    
    func testDeserialization() {
        HelperFunctions.shared.readJSONFromFile(fileName: "FoodImageSearchResponseMock") { (result) in
            switch result {
            case let .success(data):
                do {
                    
                    let searchResponse = try self.decoder.decode(SearchResponse.self, from: data)
                    XCTAssertNotNil(searchResponse)
                }
                catch {
                    XCTFail("Error : \(error.localizedDescription)")
                }
            case .failure(_):
                XCTFail("Valid path is given. Test shouldn't fail")
            }
        }
    }
}
