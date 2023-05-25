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
    var filterCityArray = [Weather]()
    var nameCitiesArray = ["Москва", "Тихвин", "Пенза", "Уфа", "Новосибирск", "Челябинск", "Екатеринбург", "Томск", "Сочи"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
    
    }
    
    @IBAction func pressPlusButton(_ sender: UIBarButtonItem) {
        alertPlusCity(name: "City", placeholder: "Enter the name of the city") { (city) in
            self.nameCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
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
        
        if isFiltering == true {
            return filterCityArray.count
        }
        
        return citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        
        let weather: Weather
        if isFiltering {
            weather = filterCityArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
        
        cell.configure(weather: weather)

        return cell
    }

    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            
            let editingRow = self.nameCitiesArray[indexPath.row]
            if let index = self.nameCitiesArray.firstIndex(of: editingRow) {
                
                if self.isFiltering == true {
                    self.filterCityArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let weather: Weather
            if isFiltering {
                weather = filterCityArray[indexPath.row]
            } else {
                weather = citiesArray[indexPath.row]
            }
            
            let dstVC = segue.destination as! DetailViewController
            dstVC.weatherModel = weather
        }
    }
}

extension ListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForDSearchText(searchController.searchBar.text!)
        
    }
    
    private func filterContentForDSearchText(_ searchText: String) {
        filterCityArray = citiesArray.filter { (weather) -> Bool in
            return weather.name.range(of: searchText, options: .caseInsensitive) != nil
        }
        tableView.reloadData()
    }

}
