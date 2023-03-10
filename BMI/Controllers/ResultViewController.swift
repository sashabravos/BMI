//
//  ResultViewController.swift
//  BMI
//
//  Created by Александра Кострова on 01.03.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    
    private var myView = MyView()
    private var calculator = Calculator()
    private let backgroundImage = MyView().makeBackgroundImageView("resultBackground")
    
    private lazy var stackView: UIStackView = {
        let stackView = myView.makeStackView( .vertical, .fill,
                                              MyView.Constants.stackViewSpacing)
        
        [resultLabel, bmiLabel, adviceLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    
    private let resultLabel = MyView().makeLabel( "YOUR RESULT", .center,
                                                  MyView.Constants.resultLabelFontSize,
                                                  .bold)
    let bmiLabel: UILabel = MyView().makeLabel( Calculator().getBMIValue(),
                                                .center, MyView.Constants.bmiLabelFontSize,
                                                .bold)
    lazy var adviceLabel: UILabel = MyView().makeLabel( "EAT SOME MORE SNACKS!",
                                                        .natural, MyView.Constants.recommendLabelFontSize,
                                                        .light)
    
    private lazy var repeatButton: UIButton = {
        let button = MyView().makeCalculateButton("RECALCULATE")
        button.addTarget(self, action: #selector(repeatButtonButtonPressed(button:)), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
    }
    // MARK: - View's Configuration Methods
    private func layoutSubviews() {
        [backgroundImage, stackView, repeatButton].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            repeatButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            repeatButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            repeatButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            repeatButton.heightAnchor.constraint(equalToConstant: MyView.Constants.buttonHeight)
        ])
    }
    
    @objc func repeatButtonButtonPressed(button: UIButton!) {
        self.dismiss(animated: true)
    }
}
