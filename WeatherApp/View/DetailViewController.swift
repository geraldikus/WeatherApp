//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Anton on 23.05.23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCity: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var  weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func refreshLables() {
        nameCityLabel.text = weatherModel?.name
        
        conditionLabel.text = weatherModel?.conditionString
        tempCity.text = "\((weatherModel?.temperature)!)"
        pressureLabel.text = "\((weatherModel?.pressureMm)!)"
        windSpeedLabel.text = "\((weatherModel?.windSpeed)!)"
        minTempLabel.text = "\((weatherModel?.tempMin)!)"
        minTempLabel.text = "\((weatherModel?.tempMax)!)"
    }

}
