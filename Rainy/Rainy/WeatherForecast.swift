//
//  WeatherForecast.swift
//  Rainy
//
//  Created by Kirill Averyanov on 17/10/16.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class WeatherForecast{
    let currentWeatherTempurature: Double?
    let rainProbability: Double?
    let timeStamp: Double
    let imageName: String
    let locationCoordinates: (Double, Double)?
    
    init(currentWeatherTempurature: Double?, rainProbability: Double?,
        timeStamp: Double, imageName: String, locationCoordinates: (Double, Double)?) {
        self.currentWeatherTempurature = currentWeatherTempurature
        self.rainProbability = rainProbability
        self.timeStamp = timeStamp
        self.imageName = imageName
        self.locationCoordinates = locationCoordinates
        
    }
}
