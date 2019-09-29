//
//  ModalViewProtocol.swift
//  Threee
//
//  Created by Paulo José on 29/09/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    lazy var backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cardViewCenterYAnchor: NSLayoutConstraint?
}


