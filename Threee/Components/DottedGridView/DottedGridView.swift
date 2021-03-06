//
//  DottedGridView.swift
//  Threee
//
//  Created by Paulo José on 30/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class DottedGridView: UIView {
    
    static let gapBetweenDots: CGFloat = 28.0
    static let dotRadius: CGFloat = 3.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawDots() {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let collumns = Int(self.frame.width / (DottedGridView.gapBetweenDots))
        let rows = Int(self.frame.height / (DottedGridView.gapBetweenDots))
        
        for i in 1...rows + 1 {
            for j in 1...collumns + 1 {
                let dot = UIView(frame: CGRect(x: DottedGridView.gapBetweenDots * CGFloat(j), y: DottedGridView.gapBetweenDots * CGFloat(i), width: DottedGridView.dotRadius, height: DottedGridView.dotRadius))
                dot.layer.masksToBounds = true
                dot.layer.cornerRadius = DottedGridView.dotRadius / 2
                dot.backgroundColor = UIColor.grey
                addSubview(dot)
            }
        }
    }
    
    
    
}
