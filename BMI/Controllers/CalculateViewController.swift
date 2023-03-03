//
//  ViewController.swift
//  BMI
//
//  Created by Александра Кострова on 27.02.2023.
//

import UIKit

final class CalculateViewController: UIViewController {
    // MARK: - Any
    private let bluePurple = UIColor(red: 0.384, green: 0.376, blue: 0.616, alpha: 1.0)
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView.init(image: UIImage(named: "calculateBackground") ?? UIImage())
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    var calculator = Calculator()
    // MARK: - StackViews
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = Constants.mainStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var heightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = Constants.smallStackViewSpacing
        stackView.contentMode = .scaleToFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var weightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = Constants.smallStackViewSpacing
        stackView.contentMode = .scaleToFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // MARK: - Labels
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "CALCULATE YOUR BMI"
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: Constants.mainLabelFontSize, weight: .bold)
        label.textAlignment = .natural
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .light)
        label.textAlignment = .natural
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var heightNumLabel: UILabel = {
        let label = UILabel()
        label.text = "\(String(format: "%.2f", heightSlider.value))m"
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .light)
        label.textAlignment = .natural
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .light)
        label.textAlignment = .natural
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var weightNumLabel: UILabel = {
        let label = UILabel()
        label.text = "\(String(format: "%.1f", weightSlider.value))Kg"
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: Constants.labelFontSize, weight: .light)
        label.textAlignment = .natural
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Sliders
    private lazy var heightSlider: UISlider = {
        let slider = UISlider()
        slider.value = 1.5
        slider.minimumValue = 0.0
        slider.maximumValue = 3.0
        slider.minimumTrackTintColor = bluePurple.withAlphaComponent(0.3)
        slider.thumbTintColor = bluePurple.withAlphaComponent(0.5)
        slider.contentHorizontalAlignment = .center
        slider.contentVerticalAlignment = .center
        slider.addTarget(self, action: #selector(self.heightSliderMoved(slider:)), for: .valueChanged)
        return slider
    }()
    private lazy var weightSlider: UISlider = {
        let slider = UISlider()
        slider.value = 100.0
        slider.minimumValue = 0.0
        slider.maximumValue = 200.0
        slider.minimumTrackTintColor = bluePurple.withAlphaComponent(0.3)
        slider.thumbTintColor = bluePurple.withAlphaComponent(0.5)
        slider.contentHorizontalAlignment = .center
        slider.contentVerticalAlignment = .center
//        slider.isContinuous = false
        slider.addTarget(self, action: #selector(self.weightSliderMoved(slider:)), for: .valueChanged)
        return slider
    }()
    // MARK: - Buttons
    private lazy var calculateButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = bluePurple
            button.titleLabel!.numberOfLines = 0
            button.setTitle("CALCULATE", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
            button.layer.cornerRadius = Constants.buttonCornerRadius
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(calculatePressed(button:)), for: .touchUpInside)
            return button
        }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
    }
    // MARK: - View's Configuration Methods
    private func addSubViews() {
        view.addSubview(backgroundImage)
        view.addSubview(mainStackView)
        addToStackView(mainStackView,
                       [mainLabel, heightStackView, heightSlider,
                        weightStackView, weightSlider, calculateButton])
        addToStackView(heightStackView, [heightLabel, heightNumLabel])
        addToStackView(weightStackView, [weightLabel, weightNumLabel])
        layoutConstraint()
    }
    private func addToStackView(_ currentStackView: UIStackView, _ elements: [Any]) {
        for element in elements {
            if let object = element as? UIView {
                currentStackView.addArrangedSubview(object)
            } else { return }
        }
    }
    private func layoutConstraint() {
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            heightStackView.heightAnchor.constraint(equalToConstant: Constants.smallStackViewHeight),
            weightStackView.heightAnchor.constraint(equalToConstant: Constants.smallStackViewHeight),
            calculateButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            heightSlider.heightAnchor.constraint(equalToConstant: Constants.sliderHeight),
            weightSlider.heightAnchor.constraint(equalToConstant: Constants.sliderHeight)
        ])
    }
    // MARK: - Actions
    @objc func heightSliderMoved(slider: UISlider!) {
        let currentValue = String(format: "%.2f", slider.value)
        heightNumLabel.text = ("\(currentValue)m")
    }
    @objc func weightSliderMoved(slider: UISlider!) {
        let currentValue = String(format: "%.1f", slider.value)
        weightNumLabel.text = ("\(currentValue)Kg")
    }
    @objc func calculatePressed(button: UIButton!) {
        let height = heightSlider.value
        let weight = weightSlider.value
        calculator.calculateBMI(height: height, weight: weight)
        let resultVC = ResultViewController()
        resultVC.view.backgroundColor = calculator.getColor()
        resultVC.bmiLabel.text = calculator.getBMIValue()
        resultVC.adviceLabel.text = calculator.getAdvice()
        self.present(resultVC, animated: true)
    }
    // MARK: - Enums
    enum Constants {
            static let mainStackViewSpacing: CGFloat = 10.0
            static let mainLabelFontSize: CGFloat = 40.0
            static let labelFontSize: CGFloat = 17.0
            static let smallStackViewSpacing: CGFloat = 0.0
            static let smallStackViewHeight: CGFloat = 21.0
            static let buttonFontSize: CGFloat = 20.0
            static let buttonCornerRadius: CGFloat = 5.0
            static let buttonHeight: CGFloat = 51.0
            static let sliderHeight: CGFloat = 60.0
        }
}
