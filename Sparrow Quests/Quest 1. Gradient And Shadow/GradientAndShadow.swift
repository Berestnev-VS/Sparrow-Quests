//
//  File.swift
//  Sparrow Quests
//
//  Created by Владимир on 10.05.2023.
//

import UIKit

class GradientAndShadowViewController: UIViewController {

    private let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 10
        return view
    }()
    
    let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.cornerRadius = 20
        gradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return gradient
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(gradientView)
        gradientView.layer.addSublayer(gradientLayer)
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = gradientView.bounds
    }
    
    private func configureConstraints() {
        
        let gradientViewConstraints = [
            gradientView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            gradientView.widthAnchor.constraint(equalToConstant: 100),
            gradientView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(gradientViewConstraints)
    }
    
}

