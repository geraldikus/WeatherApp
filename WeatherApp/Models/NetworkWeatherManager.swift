//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Anton on 22.05.23.
//

import Foundation

struct NetworkWeatherManager {
    
    func fetchWeather(latitude: Double, longitude: Double, completionHandler: @escaping(Weather) -> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
//        var request = URLRequest(url: url, timeoutInterval: 3)
        request.addValue("47925ec5-5a90-4f40-973f-c7acd5d201b2", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            //print(String(data: data, encoding: .utf8)!)
            if let weather = self.parsJSON(withData: data) {
                completionHandler(weather)
            }
        }
        task.resume()
    }
    
    func parsJSON(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else {
                return nil
            }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
