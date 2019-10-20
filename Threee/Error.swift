//
//  Error.swift
//  Threee
//
//  Created by Paulo José on 20/10/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class CustomError: Error {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
}
