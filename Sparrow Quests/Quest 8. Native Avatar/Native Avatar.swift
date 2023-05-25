//
//  Native Avatar.swift
//  Sparrow Quests
//
//  Created by Владимир on 25.05.2023.
//

import UIKit

class NativeAvatarViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 36, weight: .medium)
        iv.image = UIImage(systemName: "person.crop.circle.fill", withConfiguration: symbolConfig)
        return iv
    }()
    
    func configureAvatar() {
        guard let navigationLargeTitleView = NSClassFromString("_UINavigationBarLargeTitleView") else { return }
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.subviews.forEach { navSubview in
            if navSubview.isKind(of: navigationLargeTitleView.self) {
                navSubview.addSubview(imageView)
                
                NSLayoutConstraint.activate([
                    imageView.bottomAnchor.constraint(equalTo: navSubview.bottomAnchor, constant: -5),
                    imageView.trailingAnchor.constraint(equalTo: navSubview.trailingAnchor, constant: -10),
                    imageView.widthAnchor.constraint(equalToConstant: 36),
                    imageView.heightAnchor.constraint(equalToConstant: 36)
                ])
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Avatar"
        view.addSubview(scrollView)
        navigationController?.navigationBar.prefersLargeTitles = true
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        configureAvatar()
    }
    
}

class CustomNavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
    }
}


