//
//  ViewController.swift
//  BMI
//
//  Created by Александра Кострова on 27.02.2023.
//

import UIKit

final class CalculateViewController: UIViewController {
    
    private var calculateView: CalculateView!
    private var calculator = Calculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSubviews()
    }
    
    private func setSubviews() {
        self.calculateView = CalculateView()
        self.calculateView.delegate = self
        view.addSubview(calculateView)
        calculateView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.calculateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.calculateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.calculateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.calculateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CalculateViewController: CalculateViewDelegate {
    func heightSliderMoved(slider: UISlider!) {
        let currentValue = String(format: "%.2f", slider.value)
        calculateView.heightNumLabel.text = ("\(currentValue)m")
    }
    func weightSliderMoved(slider: UISlider!) {
        let currentValue = String(format: "%.1f", slider.value)
        calculateView.weightNumLabel.text = ("\(currentValue)Kg")
    }
    func calculateButtonPressed(button: UIButton!) {
        let height = calculateView.heightSlider.value
        let weight = calculateView.weightSlider.value
        calculator.calculateBMI(height: height, weight: weight)
        
        self.present(ResultViewController(calculator: self.calculator), animated: true)
    }
}
