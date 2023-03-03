//
//  ResultViewController.swift
//  BMI
//
//  Created by Александра Кострова on 01.03.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    // MARK: - Any
    private let bluePurple = UIColor(red: 0.384, green: 0.376, blue: 0.616, alpha: 1.0)
    var calculator = Calculator()
    lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView.init(image: UIImage(named: "resultBackground") ?? UIImage())
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    // MARK: - UIViews
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = Constants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR RESULT"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: Constants.resultLabelFontSize, weight: .bold)
        label.textAlignment = .center
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var bmiLabel: UILabel = {
        let label = UILabel()
        label.text = calculator.getBMIValue()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: Constants.bmiLabelFontSize, weight: .bold)
        label.textAlignment = .center
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var adviceLabel: UILabel = {
        let label = UILabel()
        label.text = "EAT SOME MORE SNACKS!"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: Constants.recommendLabelFontSize, weight: .light)
        label.textAlignment = .center
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var repeatButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.titleLabel!.numberOfLines = 0
        button.setTitle("RECALCULATE", for: .normal)
        button.setTitleColor(bluePurple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(repeatButtonButtonPressed(button:)), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
    }
    // MARK: - View's Configuration Methods
    private func addSubViews() {
        stackView.addArrangedSubview(resultLabel)
        stackView.addArrangedSubview(bmiLabel)
        stackView.addArrangedSubview(adviceLabel)
        view.backgroundColor = bluePurple.withAlphaComponent(0.8)
        view.addSubview(backgroundImage)
        view.addSubview(stackView)
        view.addSubview(repeatButton)
        layoutConstraint()
    }
    private func layoutConstraint() {
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
            repeatButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    // MARK: - Actions
    @objc func repeatButtonButtonPressed(button: UIButton!) {
        self.dismiss(animated: true)
    }
    // MARK: - Enums
    enum Constants {
        static let stackViewSpacing: CGFloat = 8.0
        static let resultLabelFontSize: CGFloat = 35.0
        static let bmiLabelFontSize: CGFloat = 80.0
        static let recommendLabelFontSize: CGFloat = 20.0
        static let buttonFontSize: CGFloat = 20.0
        static let buttonCornerRadius: CGFloat = 5.0
        static let buttonHeight: CGFloat = 51.0
    }
}
