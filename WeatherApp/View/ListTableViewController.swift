//
//  ListTableViewController.swift
//  WeatherApp
//
//  Created by Anton on 19.05.23.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    let emptyCity = Weather()
    var citiesArray = [Weather]()
    let nameCitiesArray = ["Москва", "Пенза", "Уфа", "Новосибирск", "Челябинск", "Екатеринбург", "Томск", "Сочи"]
    
    let networkWeatherManager = NetworkWeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        addCities()
       // networkWeatherManager.fetchWeather()
        

    }
    
    func addCities() {

        getCityWeather(citiesArray: self.nameCitiesArray) { (index, weather) in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        
        var weather = Weather()
        weather = citiesArray[indexPath.row]
        cell.configure(weather: weather)

        return cell
    }

}
