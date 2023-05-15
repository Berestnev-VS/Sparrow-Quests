import UIKit

fileprivate class RelatedAnimationViewController: UIViewController {

    let squareView = UIView()
    let slider = UISlider()
    let initialSquareSize: CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSlider()
        setupConstraints()
    }

    private func setupView() {
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.backgroundColor = .systemBlue
        squareView.layer.cornerRadius = 8
        squareView.layer.cornerCurve = .continuous
        view.addSubview(squareView)
    }

    private func setupSlider() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderEndTracking), for: [.touchUpInside, .touchUpOutside])
        view.addSubview(slider)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            squareView.widthAnchor.constraint(equalToConstant: initialSquareSize),
            squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor),
            squareView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: initialSquareSize),
            squareView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 30),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    @objc private func sliderValueChanged(_ sender: UISlider) {
        let progress = CGFloat(sender.value)
        let rotation = CGAffineTransform(rotationAngle: .pi/2 * progress)
        let scale = CGAffineTransform(scaleX: 1.0 + 0.5 * progress, y: 1.0 + 0.5 * progress)
        
        let translation = CGAffineTransform(translationX: (view.bounds.width - view.layoutMargins.right - initialSquareSize * 1.5) * progress, y: 0)
        squareView.transform = rotation.concatenating(scale).concatenating(translation)
    }


    @objc private func sliderEndTracking(_ sender: UISlider) {
        UIView.animate(withDuration: 0.5, animations: {
            sender.setValue(1.0, animated: true)
            self.sliderValueChanged(sender)
        })
    }
}
