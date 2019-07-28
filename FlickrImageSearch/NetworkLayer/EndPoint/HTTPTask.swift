//
//  HTTPTask.swift
//  MapStuff
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    
    case requestParameters(urlParameters: Parameters?)
}
