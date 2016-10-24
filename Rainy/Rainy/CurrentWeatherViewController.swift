//
//  FirstViewController.swift
//  Rainy
//
//  Created by Kirill Averyanov on 17/10/16.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


struct coords{
    var lat: Double = 35
    var lon: Double = 139
}

class CurrentWeatherViewController: UIViewController {
    @IBOutlet weak var temperatureLabel: UILabel!
    var locationManager : CLLocationManager = CLLocationManager()
    let constrain: Constants = Constants()
    var currentForecast: WeatherForecast? {
        didSet{
            reloadUI()
        }
    }
    
    var myCoords: coords = coords()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        currentForecast = updateCurrentForecast()
        print("COOORDS", myCoords.lat, myCoords.lon)
    }


    @IBAction func reloadButtonPressed(_ sender: AnyObject) {
        reloadUI()
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("didFailWithError %@", error)
        //let errorAlert : UIAlertView = UIAlertView(title: "Error", message: "Failed to get your location", delegate: nil, cancelButtonTitle: "OK")
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let currentLocation : CLLocation = locations[0] as! CLLocation
        if (!currentLocation.isEqual(nil)) {
            myCoords = coords(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
            reloadUI()
        }
        locationManager.stopUpdatingLocation()
    }


}

// MARK: - Update
extension CurrentWeatherViewController{
    func updateCurrentForecast() -> WeatherForecast?{
        let json = getJsonData()
        let weather: WeatherForecast = WeatherForecast(currentWeatherTempurature: Double(json["main"]["temp"].stringValue),
                                                       rainProbability: Double(json["rain"]["3h"].stringValue),
                                                       timeStamp: 0.0,
                                                       imageName: "lol",
                                                       locationCoordinates: (myCoords.lat, myCoords.lon))
        return weather
    }
}

// MARK: - reading json
extension CurrentWeatherViewController{
    func getJsonData() -> JSON{
        var json: JSON = nil
        var information: String = ""
        let url = "http://api.openweathermap.org/data/2.5/weather?APPID=\(constrain.apiKey)&lat=\(myCoords.lat)&lon=\(myCoords.lon)"
        Alamofire.request(url).validate().responseJSON{response in
            switch response.result{
            case .success(let value):
                print("SUCESSS")
                information = String(describing: value)
                /*information = information.replacingOccurrences(of: "\n", with: "")
                information = information.replacingOccurrences(of: "\t", with: "")
                information = information.replacingOccurrences(of: "(", with: "[")
                information = information.replacingOccurrences(of: ")", with: "]")
                information = information.replacingOccurrences(of: " ", with: "")
                information = information.replacingOccurrences(of: ";", with: ",")
                information = information.replacingOccurrences(of: ",}", with: "}")
                information = information.replacingOccurrences(of: "{", with: "{\"")
                information = information.replacingOccurrences(of: "}", with: "\"}")
                information = information.replacingOccurrences(of: "=", with: "\"=")
                information = information.replacingOccurrences(of: "=", with: "=\"")
                information = information.replacingOccurrences(of: ",", with: "\",")
                information = information.replacingOccurrences(of: ",", with: ",\"")
                information = information.replacingOccurrences(of: "\"\"", with: "\"")
                information = information.replacingOccurrences(of: "\"[", with: "[")
                information = information.replacingOccurrences(of: "]\"", with: "]")
                information = information.replacingOccurrences(of: "=\"{", with: "={")
                information = information.replacingOccurrences(of: "}\"", with: "}")
                information = information.replacingOccurrences(of: "=", with: ":")
                information = information.replacingOccurrences(of: "\"", with: "\\\"")
                print(information)*/
                print(information)
                json = JSON(information)
            case .failure(let error):
                print("ERRROR")
                print(error)
            }
        }
        print("----------------")
        print(String(describing: json))
        print(json["main"]["temp"].doubleValue)
        print(json["weather"][0]["description"].stringValue)
        print(json["coord"]["lon"].doubleValue)
        print(json["weather"][0]["main"].stringValue)
        print(json[0])
        print("----------------")
        return json
    }
}

//MARK: - get time
extension CurrentWeatherViewController{
    func getCurrentTime(){
        //let date = NSDate()
        //let calendar = NSCalendar.current
        //let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        
    }
}

// MARK: - Update UI
extension CurrentWeatherViewController{
    func reloadUI(){
        //temperatureLabel.text = "\(currentForecast!.currentWeatherTempurature!)℃
    }
}

// MARK: -
extension CurrentWeatherViewController{
    
}

//Corelocation
//closures
//presentation(slide)
//refreshcontrol







