//
//  ViewController.swift
//  NephCalc
//
//  Created by Ian Alexander Rahman on 11/19/16.
//  Copyright © 2016 Evergreen Inc. All rights reserved.
//


// Hours needed to remove gained fluid

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var fluidTextField: UITextField!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "NephCalc"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 61/255.0, green: 120/255.0, blue: 189/255.0, alpha: 1.0), NSFontAttributeName: UIFont (name: "AvenirNext-Heavy", size: 30)!]
        
        weightTextField.delegate = self
        fluidTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        
        guard weightTextField.text!.characters.count > 0 && fluidTextField.text!.characters.count > 0 else { return }
        
        hideKeyboard()
        
        guard let weight = Double(weightTextField.text!) else { return }
        guard let fluid = Double(fluidTextField.text!) else { return }
        calculateHoursNeccessary(with: weight, fluid: fluid)
    }
 

    
    func calculateHoursNeccessary(with weight: Double, fluid: Double) {
        var hoursRaw = fluid / (weight * 13)
        hoursRaw = Double(round(100 * hoursRaw) / 100)
        
        let hours = Int(hoursRaw.rounded())
        let minutes = abs(Int((hoursRaw - hoursRaw.rounded()) * 60))
        
        var hoursText = "\(hours) hours"
        var minutesText = "\(minutes) minutes"
        
        if hours == 1 {
            hoursText = "1 hour"
        }
        
        if minutes == 1 {
            minutesText = "1 minute"
        }
        
        hoursLabel.text = hoursText + " and " + minutesText
    }

}

