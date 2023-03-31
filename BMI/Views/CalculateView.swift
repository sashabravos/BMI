//
//  CalculateView.swift
//  BMI
//
//  Created by Александра Кострова on 09.03.2023.
//
import UIKit

protocol CalculateViewDelegate: AnyObject {
    
    func heightSliderMoved(slider: UISlider!)
    func weightSliderMoved(slider: UISlider!)
    func calculateButtonPressed(button: UIButton!)
}

final class CalculateView: UIView {
    
    var delegate: CalculateViewDelegate?
    
    private var myView = MakeSomeView()
    
    private let backgroundImage = MakeSomeView().makeBackgroundImageView("calculateBackground")
    private lazy var mainStackView: UIStackView = {
        let stackView = myView.makeStackView( .vertical, .fillProportionally,
                                              MakeSomeView.Constants.mainStackViewSpacing)
        
        [mainLabel, heightStackView, heightSlider,
         weightStackView, weightSlider, calculateButton].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    private lazy var heightStackView: UIStackView = {
        let stackView = myView.makeStackView( .horizontal, .equalSpacing,
                                              MakeSomeView.Constants.smallStackViewSpacing)
        
        [heightLabel, heightNumLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    private lazy var weightStackView: UIStackView = {
        let stackView = myView.makeStackView( .horizontal, .equalSpacing,
                                              MakeSomeView.Constants.smallStackViewSpacing)
        
        [weightLabel, weightNumLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    private let mainLabel = MakeSomeView().makeLabel( "CALCULATE YOUR BMI",
                                                .natural, MakeSomeView.Constants.mainLabelFontSize,
                                                .bold)
    public let heightLabel = MakeSomeView().makeLabel( "Height", .natural,
                                                  MakeSomeView.Constants.labelFontSize,
                                                  .light)
    public var heightNumLabel = MakeSomeView().makeLabel( "1.5", .natural,
                                                     MakeSomeView.Constants.labelFontSize,
                                                     .light)
    public let weightLabel = MakeSomeView().makeLabel( "Weight", .natural,
                                                  MakeSomeView.Constants.labelFontSize,
                                                  .light)
    public var weightNumLabel = MakeSomeView().makeLabel( "100", .natural,
                                                     MakeSomeView.Constants.labelFontSize,
                                                     .light)
    public lazy var heightSlider: UISlider = {
        let slider = myView.makeSlider(minValue: 0.0, maxValue: 3.0)
        slider.addTarget(self, action: #selector(heightSliderMoved(slider:)), for: .valueChanged)
        return slider
    }()
    public lazy var weightSlider: UISlider = {
        let slider = myView.makeSlider(minValue: 0.0, maxValue: 200.0)
        slider.addTarget(self, action: #selector(weightSliderMoved(slider:)), for: .valueChanged)
        return slider
    }()
    private lazy var calculateButton: UIButton = {
        let button = myView.makeCalculateButton("CALCULATE")
        button.addTarget(self, action: #selector(calculateButtonPressed(button:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCalculateViewSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCalculateViewSubviews() {
        heightSlider.value = 1.5
        weightSlider.value = 100.0
        
        [self.backgroundImage, self.mainStackView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            heightStackView.heightAnchor.constraint(equalToConstant: MakeSomeView.Constants.smallStackViewHeight),
            weightStackView.heightAnchor.constraint(equalToConstant: MakeSomeView.Constants.smallStackViewHeight),
            calculateButton.heightAnchor.constraint(equalToConstant: MakeSomeView.Constants.buttonHeight),
            heightSlider.heightAnchor.constraint(equalToConstant: MakeSomeView.Constants.sliderHeight),
            weightSlider.heightAnchor.constraint(equalToConstant: MakeSomeView.Constants.sliderHeight)
        ])
    }
    
    @objc func heightSliderMoved(slider: UISlider!) {
        self.delegate?.heightSliderMoved(slider: heightSlider)
    }
    
    @objc func weightSliderMoved(slider: UISlider!) {
        self.delegate?.weightSliderMoved(slider: weightSlider)
    }
    
    @objc func calculateButtonPressed(button: UIButton!) {
        self.delegate?.calculateButtonPressed(button: calculateButton)
    }
}
