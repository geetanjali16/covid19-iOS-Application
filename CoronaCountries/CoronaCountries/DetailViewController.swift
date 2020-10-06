//
//  DetailViewController.swift
//  CoronaCountries
//
//  Created by Geetanjali on 01/06/20.
//  Copyright © 2020 Geetanjali. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var confirmedLbl: UILabel!
    @IBOutlet weak var deathLbl: UILabel!
    @IBOutlet weak var recoveredLbl: UILabel!
    
    var covidCase:CountriesDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryNameLbl.text = covidCase?.Country
        confirmedLbl.text = "\(covidCase?.TotalConfirmed ?? 8)"
        deathLbl.text = "\(covidCase?.TotalDeaths ?? 8)"
        recoveredLbl.text = "\(covidCase?.TotalRecovered ?? 8)"

        // Do any additional setup after loading the view.
    }
    

   

}
