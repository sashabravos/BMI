//
//  CalculatorBrain.swift
//  BMI
//
//  Created by Александра Кострова on 01.03.2023.
//

import UIKit

struct Calculator {
    var bmi: BMI?
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiResult = weight / pow(height, 2)
        if bmiResult < 18.8 {
            bmi = BMI(value: bmiResult, advice: "EAT SOME MORE SNACKS!", color: .cyan .withAlphaComponent(0.9))
        } else if bmiResult < 24.9 {
            bmi = BMI(value: bmiResult, advice: "FIR AS A FIDDLE!", color: .green .withAlphaComponent(0.9))
        } else {
            bmi = BMI(value: bmiResult, advice: "EAT LESS PIES!", color: .red .withAlphaComponent(0.9))
        }
    }
    func getBMIValue() -> String {
        let bmiValue = String(format: "%.1f", bmi?.value ?? 0.0 )
        return bmiValue
    }
    func getAdvice() -> String {
        return bmi?.advice ?? "HAVE A GOOD DAY!"
    }
    func getColor() -> UIColor {
        return bmi?.color ?? .lightGray
    }
}
