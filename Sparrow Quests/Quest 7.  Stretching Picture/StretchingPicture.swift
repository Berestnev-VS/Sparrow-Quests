//
//  StretchingPicture.swift
//  Sparrow Quests
//
//  Created by Владимир on 21.05.2023.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "falcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let initialImageViewHeight: CGFloat = 270.0
    
    var scrollViewTopConstraint: NSLayoutConstraint!
    var imageViewTopConstraint: NSLayoutConstraint!
    var imageViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        scrollView.delegate = self
        
    }
    
    func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: initialImageViewHeight),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000) 
        ])
        
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: initialImageViewHeight)
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: view.topAnchor)
        scrollViewTopConstraint = scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: imageViewHeightConstraint.constant)
        
        imageViewTopConstraint.isActive = true
        imageViewHeightConstraint.isActive = true
        scrollViewTopConstraint.isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        let newImageViewHeight = initialImageViewHeight - y
        if newImageViewHeight > initialImageViewHeight {
            imageViewHeightConstraint.constant = newImageViewHeight
            imageViewTopConstraint.constant = 0
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: -y, left: 0, bottom: 0, right: 0)
        } else if newImageViewHeight < initialImageViewHeight {
            imageViewTopConstraint.constant = -y
            imageViewHeightConstraint.constant = initialImageViewHeight
        }
    }
    
}

