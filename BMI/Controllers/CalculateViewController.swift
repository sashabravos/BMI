//
//  ViewController.swift
//  BMI
//
//  Created by Александра Кострова on 27.02.2023.
//

import UIKit

final class CalculateViewController: UIViewController {
    
    private var myView = MyView()
    private var calculator = Calculator()
    private let backgroundImage = MyView().makeBackgroundImageView("calculateBackground")
    
    private lazy var mainStackView: UIStackView = {
        let stackView = myView.makeStackView( .vertical, .fillProportionally,
                                              MyView.Constants.mainStackViewSpacing)
        
        [mainLabel, heightStackView, heightSlider,
         weightStackView, weightSlider, calculateButton].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    private lazy var heightStackView: UIStackView = {
        let stackView = myView.makeStackView( .horizontal, .equalSpacing,
                                              MyView.Constants.smallStackViewSpacing)
        
        [heightLabel, heightNumLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    private lazy var weightStackView: UIStackView = {
        let stackView = myView.makeStackView( .horizontal, .equalSpacing,
                                              MyView.Constants.smallStackViewSpacing)
        
        [weightLabel, weightNumLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    
    private let mainLabel = MyView().makeLabel( "CALCULATE YOUR BMI",
                                                .natural, MyView.Constants.mainLabelFontSize,
                                                .bold)
    private let heightLabel = MyView().makeLabel( "Height", .natural,
                                                  MyView.Constants.labelFontSize,
                                                  .light)
    private var heightNumLabel = MyView().makeLabel( "1.5", .natural,
                                                     MyView.Constants.labelFontSize,
                                                     .light)
    private let weightLabel = MyView().makeLabel( "Weight", .natural,
                                                  MyView.Constants.labelFontSize,
                                                  .light)
    private var weightNumLabel = MyView().makeLabel( "100", .natural,
                                                     MyView.Constants.labelFontSize,
                                                     .light)

    private lazy var heightSlider: UISlider = {
        let slider = myView.makeSlider(value: 1.5,
                                minValue: 0.0, maxValue: 3.0)
        slider.addTarget(self, action: #selector(heightSliderMoved(slider:)), for: .valueChanged)
        return slider
    }()
    private lazy var weightSlider: UISlider = {
        let slider = myView.makeSlider(value: 100.0,
                                minValue: 0.0, maxValue: 200.0)
        slider.addTarget(self, action: #selector(weightSliderMoved(slider:)), for: .valueChanged)
        return slider
    }()

    private lazy var calculateButton: UIButton = {
        let button = myView.makeCalculateButton("CALCULATE")
        button.addTarget(self, action: #selector(calculatePressed(button:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
    }
    // MARK: - View's Configuration Methods
    private func layoutSubviews() {
        [backgroundImage, mainStackView].forEach {
            self.view.addSubview($0)
            print("\($0)")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            heightStackView.heightAnchor.constraint(equalToConstant: MyView.Constants.smallStackViewHeight),
            weightStackView.heightAnchor.constraint(equalToConstant: MyView.Constants.smallStackViewHeight),
            calculateButton.heightAnchor.constraint(equalToConstant: MyView.Constants.buttonHeight),
            heightSlider.heightAnchor.constraint(equalToConstant: MyView.Constants.sliderHeight),
            weightSlider.heightAnchor.constraint(equalToConstant: MyView.Constants.sliderHeight)
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
}
