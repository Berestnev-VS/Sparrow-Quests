//
//  ViewController.swift
//  Sparrow Quests
//
//  Created by Владимир on 14.05.2023.
//

import UIKit

fileprivate class CompactViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    let popoverButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Popover", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.sizeToFit()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(popoverButton)
        
        popoverButton.addTarget(self, action: #selector(showPopover), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        popoverButton.sizeToFit()
        popoverButton.center.x = view.frame.width / 2
        popoverButton.frame.origin.y = view.safeAreaInsets.top + 2
    }
    
    @objc func showPopover(sender: UIButton) {
        let popoverContentController = PopoverContentController()
        popoverContentController.modalPresentationStyle = .popover
        popoverContentController.preferredContentSize = CGSize(width: 300, height: 280)
        
        if let popoverPresentationController = popoverContentController.popoverPresentationController {
            popoverPresentationController.sourceView = sender
            popoverPresentationController.sourceRect = sender.bounds
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.delegate = self
        }
        
        present(popoverContentController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

fileprivate class PopoverContentController: UIViewController {
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["280", "150"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system) 
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    var previousHeightForController: CGFloat = 280 
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        view.addSubview(segmentedControl)
        view.addSubview(closeButton)
        setupConstraints()
        
        closeButton.addTarget(self, action: #selector(closePopover), for: .touchUpInside)
        segmentedControl.addTarget(self, action: #selector(changeHeight), for: .valueChanged)
    }
    
    @objc func changeHeight(sender: UISegmentedControl) { 
        guard let floatValue = Float(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "") else { return }
        let height: CGFloat = CGFloat(floatValue)
        previousHeightForController = height
        UIView.animate(withDuration: 0.3) {
            self.preferredContentSize = CGSize(width: 300, height: height)
        }
    }
    
    @objc func closePopover() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 5)
        ])
    }
}
