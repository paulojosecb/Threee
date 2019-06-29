//
//  HomeViewModelDelegate.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate {
    func didUpdate(day: Day)
    func didReceivedError(error: Error)
}
