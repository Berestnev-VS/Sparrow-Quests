//
//  File.swift
//  Sparrow Quests
//
//  Created by Владимир on 17.05.2023.
//

import UIKit

class InertialSquareViewController: UIViewController {
    
    var squareView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.layer.cornerRadius = 12
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        squareView.center = self.view.center
        self.view.addSubview(squareView)
        
        animator = UIDynamicAnimator(referenceView: view)
        
        collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: view)
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        snap = UISnapBehavior(item: squareView, snapTo: touchLocation)
        animator.addBehavior(snap)
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let touchLocation = sender.location(in: view)
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        snap = UISnapBehavior(item: squareView, snapTo: touchLocation)
        animator.addBehavior(snap)
    }
    
}

