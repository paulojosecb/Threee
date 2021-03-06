//
//  PageTitleLabelView.swift
//  Threee
//
//  Created by Paulo José on 30/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class PageTitleLabelView: UIView {
    
    static let height: CGFloat = 45.0
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.font = UIFont.title
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.yellow
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func draw(_ rect: CGRect) {
//        self.frame.size = CGSize(width: titleLabel.intrinsicContentSize.width + 32, height: self.frame.size.height)
//    }
    
    func setupViews() {
        addSubview(titleLabel)
        
        self.heightAnchor.constraint(equalToConstant: PageTitleLabelView.height).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        print(titleLabel.intrinsicContentSize.width)
        
        self.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width + 65).isActive = true
    }

    
    
    
}
