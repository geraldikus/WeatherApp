//
//  Weather.swift
//  WeatherApp
//
//  Created by Anton on 22.05.23.
//

import Foundation


struct Weather {
    
    var name: String = "Loading..."
    var temperature: Int = 0
    var temperatureString: String {
        return String(temperature)
    }
    var conditionCode: String = "" //для отображения изображения
    var url: String = ""
    var condition: String = ""
    var pressureMm: Int = 0
    var windSpeed: Int = 0
    var tempMin: Int = 0
    var tempMax: Int = 0
    
    var conditionString: String { // для русского языка
        switch condition {
        case "clear": return "ясно"
        case "partly-cloudy": return "малооблачно"
        case "cloudy": return "облачно с прояснениями"
        case "overcast": return "пасмурно"
        case "drizzle": return "морось"
        case "light-rain": return "небольшой дождь"
        case "rain": return "дождь"
        case "moderate-rain": return "умеренно сильный дождь"
        case "heavy-rain": return "сильный дождь"
        case "continuous-heavy-rain": return "длительный сильный дождь"
        case "showers": return "ливень"
        case "wet-snow": return "дождь со снегом"
        case "light-snow": return "небольшой снег"
        case "snow": return "снег"
        case "snow-showers": return "снегопад"
        case "hail": return "град"
        case "thunderstorm": return "гроза"
        case "thunderstorm-with-rain": return "дождь с грозой"
        case "thunderstorm-with-hail": return "гроза с градом"
            
        default: return "Загрузка..."
        }
    }
    
    init?(weatherData: WeatherData) {

        temperature = weatherData.fact.temp
        conditionCode = weatherData.fact.icon
        url = weatherData.info.url
        condition = weatherData.fact.condition
        pressureMm = weatherData.fact.pressureMm
        windSpeed = weatherData.fact.windSpeed
        tempMin = weatherData.forecasts.first!.parts.day.tempMin!
        tempMax = weatherData.forecasts.first!.parts.day.tempMax!
    }
    
    init() {

    }
}
