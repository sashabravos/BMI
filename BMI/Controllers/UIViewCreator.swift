//
//  UIViewCreator.swift
//  BMI
//
//  Created by Александра Кострова on 14.03.2023.
//

import UIKit

final class MakeSomeView: UIView {

    let customColor = UIColor(red: 0.384, green: 0.376, blue: 0.616, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func makeBackgroundImageView(_ imageName: String) -> UIImageView {
        let backgroundImage = UIImageView.init(image: UIImage(named: imageName) ?? UIImage())
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }
    
    public func makeStackView(_ axis: NSLayoutConstraint.Axis,
                              _ distribution: UIStackView.Distribution,
                              _ spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = spacing
        return stackView
    }
    
    public func makeLabel(_ title: String,
                          _ textAlignment: NSTextAlignment,
                          _ fontSize: CGFloat,
                          _ fontWeight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        label.textAlignment = textAlignment
        label.isEnabled = true
        return label
    }

    public func makeSlider(minValue: Float, maxValue: Float) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        slider.minimumTrackTintColor = customColor.withAlphaComponent(0.3)
        slider.thumbTintColor = customColor.withAlphaComponent(0.5)
        slider.contentHorizontalAlignment = .center
        slider.contentVerticalAlignment = .center
        return slider
    }

    public func makeCalculateButton(_ title: String) -> UIButton {
            let button = UIButton()
            button.backgroundColor = customColor
            button.titleLabel!.numberOfLines = 0
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
            button.layer.cornerRadius = Constants.buttonCornerRadius
            return button
        }

    public enum Constants {
            static let mainStackViewSpacing: CGFloat = 10.0
            static let mainLabelFontSize: CGFloat = 40.0
            static let labelFontSize: CGFloat = 17.0
            static let smallStackViewSpacing: CGFloat = 0.0
            static let smallStackViewHeight: CGFloat = 21.0
            static let buttonFontSize: CGFloat = 20.0
            static let buttonCornerRadius: CGFloat = 5.0
            static let buttonHeight: CGFloat = 51.0
            static let sliderHeight: CGFloat = 60.0
            static let stackViewSpacing: CGFloat = 8.0
            static let resultLabelFontSize: CGFloat = 35.0
            static let bmiLabelFontSize: CGFloat = 80.0
            static let recommendLabelFontSize: CGFloat = 20.0
        }
    }
