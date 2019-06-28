//
//  AuthPresenter.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

protocol AuthPresenter {
    func sucess(_ case: AuthSucess)
    func failure(error: AuthError)
}
