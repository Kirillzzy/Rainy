//
//  SecondViewController.swift
//  Rainy
//
//  Created by Kirill Averyanov on 17/10/16.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeWeatherViewController: UIViewController {

    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var imageWeatherView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    private var cityName: String = "Saint Petersburg"
    private let constrain: Constants = Constants()
    private var currentForecast: WeatherForecast? {
        didSet{
            reloadUI()
        }
    }
    
    private let photoResources: [String: UIImage] = [
        "01d":#imageLiteral(resourceName: "01d"),
        "01n":#imageLiteral(resourceName: "01n"),
        "02d":#imageLiteral(resourceName: "02d"),
        "02n":#imageLiteral(resourceName: "02n"),
        "03d":#imageLiteral(resourceName: "03d"),
        "03n":#imageLiteral(resourceName: "03n"),
        "04d":#imageLiteral(resourceName: "04d"),
        "04n":#imageLiteral(resourceName: "04n"),
        "09d":#imageLiteral(resourceName: "09d"),
        "09n":#imageLiteral(resourceName: "09n"),
        "10d":#imageLiteral(resourceName: "10d"),
        "10n":#imageLiteral(resourceName: "10n"),
        "11d":#imageLiteral(resourceName: "11d"),
        "11n":#imageLiteral(resourceName: "11n"),
        "13d":#imageLiteral(resourceName: "13d"),
        "13n":#imageLiteral(resourceName: "13n"),
        "50d":#imageLiteral(resourceName: "50d"),
        "50n":#imageLiteral(resourceName: "50n")
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCurrentForecast()
    }

    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        reloadUI()
    }
    
    private func updateCurrentForecast(){
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather",
                          parameters: ["q": cityName,
                                       "APPID": constrain.apiKey,
                                       "units":"metric"])
            .responseJSON{response in
                guard response.result.isSuccess else{
                    return
                }
                let json = JSON(response.result.value!)
                self.currentForecast = WeatherForecast(currentWeatherTempurature: json["main"]["temp"].double,
                                                       timeStamp: self.getCurrentTime(),
                                                       imageName: json["weather"][0]["icon"].string!,
                                                       locationCoordinates: (0, 0),
                                                       humidity: json["main"]["humidity"].int,
                                                       pressure: json["main"]["pressure"].int,
                                                       wind: json["wind"]["speed"].double, cityName: json["name"].string,
                                                       stateWeather: json["weather"][0]["description"].string)
        }
    }
    
    private func getCurrentTime() -> String{
        let date = NSDate()
        let calendar = NSCalendar.current
        var currentTime: String
        let components = calendar.dateComponents([.hour, .minute], from: date as Date!)
        var hour: String = String(describing: components.hour!)
        var minute: String = String(describing: components.minute!)
        if hour.characters.count == 1{
            hour = "0" + hour
        }
        if(minute.characters.count == 1){
            minute = "0" + minute
        }
        currentTime = "\(hour):\(minute)"
        return currentTime
    }
    
    private func reloadUI(){
        updateCurrentForecast()
        timeLabel.text = "Updated: \(currentForecast!.timeStamp)"
        if let temp = currentForecast?.currentWeatherTempurature{
            temperatureLabel.text = "\(temp)℃"
        }
        if let city = currentForecast?.cityName{
            cityNameLabel.text = city
        }
        if let press = currentForecast?.pressure{
            pressureLabel.text = "\(press)"
        }
        if let hum = currentForecast?.humidity{
            humidityLabel.text = "\(hum)"
        }
        if let wi = currentForecast?.wind{
            windLabel.text = "\(wi)"
        }
        if let st = currentForecast?.stateWeather{
            stateLabel.text = st
        }
        imageWeatherView.image = photoResources[(currentForecast?.imageName)!]
    }



}

