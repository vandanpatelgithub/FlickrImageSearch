//
//  HelperFunctions.swift
//  FlickrImageSearchTests
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

enum ReadJSONError: Error {
    case invalidURL
}

class HelperFunctions {
    
    private init() {}
    static let shared = HelperFunctions()
    
    func readJSONFromFile(fileName: String, completion: @escaping (Result<Data, Error>) ->()) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"), !fileName.isEmpty else {
            completion(.failure(ReadJSONError.invalidURL))
            return
        }
        
        do {
            let data = try Data(contentsOf: url, options: .alwaysMapped)
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
}

