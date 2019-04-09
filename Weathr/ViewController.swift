//
//  ViewController.swift
//  Weathr
//
//  Created by Maroš Kováč on 08/03/2019.
//  Copyright © 2019 Maroš Kováč. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!

    @IBOutlet weak var conditionImageLabel: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!

    @IBOutlet weak var temperatureLabel: UILabel!

    @IBOutlet weak var backgroundView: UIView!
    
    let gradientLayer = CAGradientLayer()
    
    var apiKey: String?
    var lat = 11.344553
    var lon = 104.33322
    var activityIndicator: NVActivityIndicatorView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "data", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: path)
        apiKey = dict!.object(forKey: "apiKey") as? String
        
        backgroundView.layer.addSublayer(gradientLayer)
        
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width - indicatorSize) / 2, y: (view.frame.height - indicatorSize) / 2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        activityIndicator.backgroundColor = UIColor.black
        view.addSubview(activityIndicator)
        
        locationManager.requestWhenInUseAuthorization()
        
        activityIndicator.startAnimating()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        
        if let apiKey = apiKey {
            Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric").responseJSON {
                response in
                self.activityIndicator.stopAnimating()
                if let responseStr = response.result.value {
                    let jsonResponse = JSON(responseStr)
                    
                    let jsonWeather = jsonResponse["weather"].array![0]
                    let jsonTemperature = jsonResponse["main"]
                    let iconName = jsonWeather["icon"].stringValue
                    
                    self.locationLabel.text = jsonResponse["name"].stringValue
                    // TODO: Switch for setting weather image based on the response icon name
                    print(jsonWeather)
                    print(jsonTemperature)
                }
            }
        }
    }
}

