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
    private let backgroundImage = MyView().makeBackgroundImageView(imageName: "resultBackground")
    
    private lazy var stackView: UIStackView = {
        let stackView = myView.makeStackView(axis: .vertical,
                                             distribution: .fill,
                                             spacing: MyView.Constants.stackViewSpacing)
        
        [resultLabel, bmiLabel, adviceLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    
    private let resultLabel = MyView().makeLabel(title: "YOUR RESULT",
                                                 fontSize: MyView.Constants.resultLabelFontSize,
                                                 fontWeight: .bold)
    let bmiLabel: UILabel = MyView().makeLabel(title: Calculator().getBMIValue(),
                                               fontSize: MyView.Constants.bmiLabelFontSize,
                                               fontWeight: .bold)
    lazy var adviceLabel: UILabel = MyView().makeLabel(title: "EAT SOME MORE SNACKS!",
                                                       fontSize: MyView.Constants.recommendLabelFontSize,
                                                       fontWeight: .light)
    
    private lazy var repeatButton: UIButton = {
        let button = MyView().makeCalculateButton(title: "RECALCULATE")
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
