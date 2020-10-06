//
//  CoronaData.swift
//  CoronaCountries
//
//  Created by Geetanjali on 28/05/20.
//  Copyright © 2020 Geetanjali. All rights reserved.
//

import Foundation



struct COVID:Codable {
    var Countries:[CountriesDetails]
}

struct CountriesDetails:Codable {
    var Country:String
    var TotalConfirmed:Int
    var TotalDeaths:Int
    var TotalRecovered:Int
}
