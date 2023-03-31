//
//  ResultViewController.swift
//  BMI
//
//  Created by Александра Кострова on 01.03.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    
    var resultView: ResultView!
    var calculator: Calculator

    init(calculator: Calculator) {
        self.calculator = calculator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setSubviews()
    }
    
        private func setSubviews() {
            self.resultView = ResultView(calculator: self.calculator)
            self.resultView.delegate = self
            view.addSubview(resultView)
            resultView.translatesAutoresizingMaskIntoConstraints = false
    
            NSLayoutConstraint.activate([
                self.resultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                self.resultView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                self.resultView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                self.resultView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
    
extension ResultViewController: ResultViewDelegate {
    func repeatButtonPressed(button: UIButton!) {
        self.dismiss(animated: true)
    }
}
