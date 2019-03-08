//
//  ViewController.swift
//  Weathr
//
//  Created by Maroš Kováč on 08/03/2019.
//  Copyright © 2019 Maroš Kováč. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!

    @IBOutlet weak var conditionImageLabel: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!

    @IBOutlet weak var temperatureLabel: UILabel!

    @IBOutlet weak var backgroundView: UIView!
    
    let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.addSublayer(gradientLayer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBlueGradientBackground()
    }

    func setBlueGradientBackground() {
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0, alpha: 1.0).cgColor
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }

    func setGreyGradientBackground() {
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
}

