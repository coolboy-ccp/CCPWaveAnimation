//
//  ViewController.swift
//  CCPWaveAnimation
//
//  Created by 储诚鹏 on 2018/12/25.
//  Copyright © 2018 储诚鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var whiteView: UIView!
    
    private let redColor = UIColor(red: 221.0 / 225, green: 69.0 / 225, blue: 69.0 / 225, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redView.backgroundColor = redColor
    }

    @IBAction func runWave(_ sender: UIButton) {
        if sender.isSelected {
            redView.stopWave()
            whiteView.stopWave()
        }
        else {
            redView.startWave()
            whiteView.startWave(color: redColor, speed: 10, height: 5)
        }
        sender.isSelected = !sender.isSelected
    }
    
}

