//
//  ResultView.swift
//  BMI
//
//  Created by Александра Кострова on 14.03.2023.
//

import UIKit

protocol ResultViewDelegate: AnyObject {
    func repeatButtonPressed(button: UIButton!)
}

final class ResultView: UIView {
    
    var delegate: ResultViewDelegate?
    
    private var myView = MakeSomeView()
    private let backgroundImage = MakeSomeView().makeBackgroundImageView("resultBackground")
    
    private lazy var stackView: UIStackView = {
        let stackView = myView.makeStackView( .vertical, .fill,
                                              MakeSomeView.Constants.stackViewSpacing)
        
        [resultLabel, bmiLabel, adviceLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    
    private let resultLabel = MakeSomeView().makeLabel( "YOUR RESULT", .center,
                                                        MakeSomeView.Constants.resultLabelFontSize,
                                                        .bold)
    let bmiLabel: UILabel = MakeSomeView().makeLabel( Calculator().getBMIValue(),
                                                      .center, MakeSomeView.Constants.bmiLabelFontSize,
                                                      .bold)
    lazy var adviceLabel: UILabel = MakeSomeView().makeLabel( "EAT SOME MORE SNACKS!",
                                                              .center, MakeSomeView.Constants.recommendLabelFontSize,
                                                              .light)
        
    private lazy var repeatButton: UIButton = {
        let button = MakeSomeView().makeCalculateButton("RECALCULATE")
        button.addTarget(self, action: #selector(self.repeatButtonPressed(button:)), for: .touchUpInside)
        return button
    }()
    
    init(calculator: Calculator) {
        super.init(frame: .zero)

        self.setResultViewSubviews()
        self.bmiLabel.text = calculator.getBMIValue()
        self.adviceLabel.text = calculator.getAdvice()
        self.backgroundColor = calculator.getColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setResultViewSubviews() {
        [self.backgroundImage, self.stackView, self.repeatButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.layoutMarginsGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor),
            repeatButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            repeatButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            repeatButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            repeatButton.heightAnchor.constraint(equalToConstant: MakeSomeView.Constants.buttonHeight)
        ])
    }
    
    @objc func repeatButtonPressed(button: UIButton!) {
        self.delegate?.repeatButtonPressed(button: repeatButton)
    }
}
