//
//  VideViewController.swift
//  Threee
//
//  Created by Paulo José on 24/08/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

enum Illustration: String {
    case happy = "happy"
    case sad = "sad"
    case love = "confirmation"
    case angry = "angry"
}

struct Message {
    let type: Illustration
    let message: String
    let time: TimeInterval
}

class VideoViewController: UIViewController {
    
    let messages = [
        Message(type: .happy, message: "Olá, mundo", time: 4.0),
        Message(type: .happy, message: "Meu nome é Threee. Eu sou um app iOS desenvolvido pelo Paulo", time: 6.5),
        Message(type: .angry, message: "Com licença...Obrigado.", time: 4.0),
        Message(type: .love, message: "Nesse app que tenta simular o feeling de um bullet journal, ele usou a fonte Mali", time: 12),
        Message(type: .happy, message: "No entanto, já vi ele usando fontes como Avenir, Railway e San Franscisco em outros apps por aí", time: 12),
        Message(type: .love, message: "Ahh....San Francisco...", time: 4.0),
        Message(type: .sad, message: "Opa…Acho que deu minha hora", time: 5.0),
        Message(type: .love, message: "Te vejo na App Store em breve, viu!", time: 10.0)
    ]
    
    var counter = 0
    
    var meImageConstrait: NSLayoutConstraint?
    
    var timer: Timer?
    
    lazy var dottedGrid: DottedGridView = {
        return DottedGridView(frame: self.view.frame)
    }()
    
    lazy var helloImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcome")
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var threee: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: self.messages[0].type.rawValue)
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var meImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "me")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.label18
        label.text = ""
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        dottedGrid.drawDots()
    }
    
    func setupViews() {
        
        self.view.addSubview(dottedGrid)
        self.view.addSubview(helloImage)
        self.view.addSubview(threee)
        self.view.addSubview(textLabel)
        self.view.addSubview(meImage)
        
        dottedGrid.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        dottedGrid.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dottedGrid.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        dottedGrid.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        helloImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        helloImage.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 50).isActive = true
        
        threee.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        threee.topAnchor.constraint(equalTo: helloImage.bottomAnchor, constant: 100).isActive = true
        threee.widthAnchor.constraint(equalToConstant: 100).isActive = true
        threee.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: threee.bottomAnchor, constant: 25).isActive = true
        textLabel.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        
        meImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        meImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        meImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        meImageConstrait = meImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -300)
        meImageConstrait?.isActive = true
        
        textLabel.setTextWithTypeAnimation(typedText: messages[counter].message, characterDelay: 8)
        print(messages[counter].time)
        _ = Timer.scheduledTimer(timeInterval: messages[counter].time, target: self, selector: #selector(update), userInfo: nil, repeats: false)
    }
    
    @objc func update() {
        counter += 1
        
        if (counter == 2) {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseInOut], animations: {
                self.meImageConstrait?.constant = -100
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        if (counter == 3) {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseInOut], animations: {
                self.meImageConstrait?.constant = -300
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        if (counter < messages.count) {
            updateText()
            updateImage()
            
             _ = Timer.scheduledTimer(timeInterval: messages[counter].time, target: self, selector: #selector(update), userInfo: nil, repeats: false)
        }
        
    }
    
    func updateImage() {
        threee.image = UIImage(named: messages[counter].type.rawValue)
    }
    
    func updateText() {
        textLabel.text = ""
        textLabel.setTextWithTypeAnimation(typedText: messages[counter].message, characterDelay: 8)
    }
    
}

extension VideoViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomCurlTransition(type: .down)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomCurlTransition(type: .up)
    }
}
