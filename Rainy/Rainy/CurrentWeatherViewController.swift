//
//  FirstViewController.swift
//  Rainy
//
//  Created by Kirill Averyanov on 17/10/16.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    var currentForecast: WeatherForecast? {
        didSet{
            reloadUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentForecast = updateCurrentForecast()
        
    }



}

// MARK: - Update
extension CurrentWeatherViewController{
    func updateCurrentForecast() -> WeatherForecast?{
        // ... Magic ...
        return nil
    }
}

// MARK: - Update UI
extension CurrentWeatherViewController{
    func reloadUI(){
        
    }
}
