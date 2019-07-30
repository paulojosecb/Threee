//
//  AlertModalViewController.swift
//  Threee
//
//  Created by Paulo José on 18/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

enum AlertMode: String {
    case warning = "warning"
    case welcome = "welcome"
    case planning = "planning"
    case confirmation = "confirmation"
}

class AlertModalViewController: UIViewController {
    
    let mode: AlertMode
    let customText: String?
    
    var cardViewCenterYAnchor: NSLayoutConstraint?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    lazy var backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    lazy var dottedGrid: DottedGridView = {
//        return DottedGridView(frame: .zero)
//    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var illustration: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: self.mode.rawValue != "welcome" ? self.mode.rawValue : "confirmation")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var tag: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        
        switch mode {
        case .confirmation: view.backgroundColor = .green
        case .warning: view.backgroundColor = .salmon
        default: view.backgroundColor = .yellow
        }
        
        return view
    }()
    
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.title
        
        switch mode {
        case .confirmation:
            label.text = "Congratulations"
        case .warning:
            label.text = "Oh no!"
        case .welcome:
            label.text = "Welcome"
        case .planning:
            label.text = "Planning Time!"
        }
        
        return label
    }()
    
    lazy var text: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = .regular18
        label.numberOfLines = 5
        label.text = populateText(mode: mode)
        return label
    }()
    
    init(mode: AlertMode, customText: String? = nil) {
        self.mode = mode
        self.customText = customText
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlerDismiss(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
    }
    
    override func viewDidLayoutSubviews() {
//        dottedGrid.drawDots()
    }
    
    func setupViews() {
        view.addSubview(backdropView)
        view.addSubview(cardView)
//        view.addSubview(dottedGrid)
        view.addSubview(illustration)
        view.addSubview(tag)
        view.addSubview(tagLabel)
        view.addSubview(text)
        
        backdropView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backdropView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backdropView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        cardView.widthAnchor.constraint(equalToConstant: 285).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 345).isActive = true
        cardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cardViewCenterYAnchor = cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        cardViewCenterYAnchor?.isActive = true
        
//        dottedGrid.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
//        dottedGrid.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
//        dottedGrid.leftAnchor.constraint(equalTo: cardView.leftAnchor).isActive = true
//        dottedGrid.rightAnchor.constraint(equalTo: cardView.rightAnchor).isActive = true
        
        illustration.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 27).isActive = true
        illustration.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        illustration.widthAnchor.constraint(equalToConstant: 107).isActive = true
        illustration.heightAnchor.constraint(equalToConstant: 94).isActive = true
        
        tag.topAnchor.constraint(equalTo: illustration.bottomAnchor, constant: 16).isActive = true
        tag.widthAnchor.constraint(equalToConstant: 227).isActive = true
        tag.heightAnchor.constraint(equalToConstant: 45).isActive = true
        tag.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        
        tagLabel.widthAnchor.constraint(equalToConstant: tagLabel.intrinsicContentSize.width).isActive = true
        tagLabel.heightAnchor.constraint(equalToConstant: tagLabel.intrinsicContentSize.height).isActive = true
        tagLabel.centerXAnchor.constraint(equalTo: tag.centerXAnchor).isActive = true
        tagLabel.centerYAnchor.constraint(equalTo: tag.centerYAnchor).isActive = true
        
        text.topAnchor.constraint(equalTo: tag.bottomAnchor, constant: 16).isActive = true
        text.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 29).isActive = true
        text.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -29).isActive = true
        text.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -29).isActive = true
    }
    
    @objc func handlerDismiss(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
    }
    
    func populateText(mode: AlertMode) -> String {
        
        if (customText != nil) {
            return customText!
        }
        
        switch mode {
        case .welcome:
            return "You can start your jorney by adding the three most important things you can do today to add value to your life"
        case .confirmation:
            return "You’ve finished all your important tasks for today!\nGreat job!"
        case .planning:
            return "It’s time to plan what you will do tomorrow. Remember to select only the three most important things"
        case .warning:
            return "Something went wrong. But don’t worry, we are already fixing it."
        }
    }
    
}

extension AlertModalViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalPushTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalPopTransition()
    }
}
