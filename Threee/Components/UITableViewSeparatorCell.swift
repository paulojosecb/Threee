//
//  TableViewSeparator.swift
//  Threee
//
//  Created by Paulo José on 08/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class UITableViewSeparatorCell: UITableViewCell {
    
    var height: CGFloat = 0
    static let reuseIdentifier = "UITableViewSeparatorCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.init(white: 0, alpha: 0)
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
}
