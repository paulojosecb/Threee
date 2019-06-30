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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
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
        
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        print(titleLabel.intrinsicContentSize.width)
        
        self.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width + 32).isActive = true
    }

    
    
    
}
