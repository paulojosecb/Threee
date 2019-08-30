//
//  VideoViewController.swift
//  Threee
//
//  Created by Paulo José on 24/08/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class MatrixViewController: UIViewController {
    
    let texts = ["Conectando...", "Definindo a altura-x...", "Baixando Mali-Bold do Google Fonts..."]
    var counter = 0
    
    var timer: Timer?

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.retro
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var matrix: JSMatrixCodeRainView = {
        let matrix = JSMatrixCodeRainView(frame: self.view.frame)
        matrix.translatesAutoresizingMaskIntoConstraints = false
        return matrix
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(matrix)
        self.view.addSubview(backgroundView)
        self.view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
        label.setTextWithTypeAnimation(typedText: texts[counter], characterDelay: 10)
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateText), userInfo: nil, repeats: true)
    }
    
    @objc func updateText() {
        counter += 1
        label.text = ""
        
        if (counter <= 2) {
            label.setTextWithTypeAnimation(typedText: texts[counter], characterDelay: 10)
        } else {
            timer?.invalidate()
            timer = nil
            
            let vc = VideoViewController()
            vc.modalPresentationStyle = .fullScreen
//            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true, completion: nil)
        }
    }
    
}
