//
//  UnderlineView.swift
//  Threee
//
//  Created by Paulo José on 01/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class UnderlineView: UIView {
    
    lazy var yellowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(yellowView)
        addSubview(blackView)
        
        yellowView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        yellowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        yellowView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        yellowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        blackView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        blackView.leftAnchor.constraint(equalTo: yellowView.leftAnchor, constant: 2).isActive = true
        blackView.rightAnchor.constraint(equalTo: yellowView.rightAnchor, constant: -2).isActive = true
        blackView.centerYAnchor.constraint(equalTo: yellowView.centerYAnchor).isActive = true
    }
    
    
    
}
