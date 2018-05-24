//
//  ViewController.swift
//  GravityMeter
//
//  Created by Alexey Gain on 5/15/18.
//  Copyright © 2018 Alexey Gain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ogField: UITextField!
    @IBOutlet weak var fgField: UITextField!
    @IBOutlet weak var abvField: UILabel!
    @IBOutlet weak var tempSliderVal: UISlider!
    @IBOutlet weak var tempField: UILabel!
    @IBOutlet weak var scaleSelectVal: UISegmentedControl!
    
    var scale = 1
    var cal_temp = 68.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        tempSlider(self)
        calculateABV()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        calculateABV()
    }

    @IBAction func tempSlider(_ sender: AnyObject) {
        let temp = String(format: "%.1f", tempSliderVal.value)
        tempField.text = temp
        calculateABV()
        
    }
    
    @IBAction func scaleSelect(_ sender: Any) {
        if scaleSelectVal.selectedSegmentIndex == 0 {
            scale = 0
            tempSliderVal.minimumValue = -1000
            tempSliderVal.maximumValue = 1000
            tempSliderVal.value = (tempSliderVal.value-32)*0.5556
            cal_temp = (cal_temp-32)*0.5556
            tempSliderVal.minimumValue = 0
            tempSliderVal.maximumValue = 100
            tempSlider(self)
        } else {
            scale = 1
            tempSliderVal.minimumValue = -1000
            tempSliderVal.maximumValue = 1000
            tempSliderVal.value = (tempSliderVal.value*1.8)+32
            cal_temp = 68.0
            tempSliderVal.minimumValue = 32
            tempSliderVal.maximumValue = 212
            tempSlider(self)
        }
    }
    
    
    @IBAction func ogDown(_ sender: UIButton) {
        if ogField.text != "" {
            if let ogText = ogField?.text {
                let og = Double(ogText)! - 0.001
                ogField.text = String(format: "%.3f", og)
            }
        }
        calculateABV()
    }
    
    @IBAction func ogUp(_ sender: UIButton) {
        if ogField.text != "" {
            if let ogText = ogField?.text {
                let og = Double(ogText)! + 0.001
                ogField.text = String(format: "%.3f", og)
            }
        }
        calculateABV()
    }
    
    @IBAction func fgDown(_ sender: UIButton) {
        if fgField.text != "" {
            if let fgText = fgField?.text {
                let fg = Double(fgText)! - 0.001
                fgField.text = String(format: "%.3f", fg)
            }
        }
        calculateABV()
    }
    
    @IBAction func fgUp(_ sender: UIButton) {
        if fgField.text != "" {
            if let fgText = fgField?.text {
                let fg = Double(fgText)! + 0.001
                fgField.text = String(format: "%.3f", fg)
            }
        }
        calculateABV()
    }
    
    func calculateABV() {
        if ogField.text != "", fgField.text != "" {
            if let ogText = ogField?.text, let fgText = fgField?.text {
                var og = Double(ogText)
                var fg = Double(fgText)
                let temp = Double(tempField.text!)
                let measured_temp = sgRatio(temp: temp!)
                let calibrated_temp = sgRatio(temp: cal_temp)
                og = og!*(measured_temp/calibrated_temp)
                fg = fg!*(measured_temp/calibrated_temp)
                let abv = (og!-fg!)*131.25
                abvField.text = String(format: "%.2f", abv)+"%"
            }
        }
    }


    
}

