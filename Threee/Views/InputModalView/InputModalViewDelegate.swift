//
//  InputModalViewDelegate.swift
//  Threee
//
//  Created by Paulo José on 09/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

protocol InputModalViewDelegate {
    func createItemWith(name: String)
    func editItemWith(name: String, on index: Int)
}
