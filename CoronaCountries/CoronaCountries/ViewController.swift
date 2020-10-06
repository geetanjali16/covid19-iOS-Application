//
//  ViewController.swift
//  CoronaCountries
//
//  Created by Geetanjali on 27/05/20.
//  Copyright © 2020 Geetanjali. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {
    
     var countries = [CountriesDetails]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var DateLabbel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var totalCountries: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        
        
        
        DateTime()
        getData()
        
        
        
        
        
        
    }
    
    
    func DateTime(){
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/M/yyyy" // Set the way the date should be displayed
        //dispaly date in label
        DateLabbel.text = formatter.string(from: date as Date)
        formatter.timeStyle = .medium
        //display time in labbel
        timeLabel.text = "\(formatter.string(from: date as Date))"
    }
    
    
    func getData(){
                let Baseurl = "https://api.covid19api.com/"
                let url = Baseurl+"summary"
                
                guard let serviceURL = URL(string: url ) else {fatalError()}
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: serviceURL) { (data, session, error) in
                    if let session = session{
                        print(session)
                    }
                    
                    guard let data = data else {return}
                    do{
                        let decoder = JSONDecoder()
                        let jsonCountries = try decoder.decode(COVID.self, from: data)
                        print(jsonCountries)
                        DispatchQueue.main.async {
                            self.countries = jsonCountries.Countries
                            self.tableView.reloadData()
                            
                            
//                            self.totalCountries.text = "\(self.countries.count)"
                        }
                        
                        
                    }catch{
                        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                dataTask.resume()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            getData()
        }else if searchBar.selectedScopeButtonIndex == 0{
            countries = countries.filter({ (CountriesDetails) -> Bool in
                return CountriesDetails.Country.lowercased().contains(searchText.lowercased())
            })
        }
    }
    
    



}




extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = country.Country
        cell.detailTextLabel?.text = "\(country.TotalConfirmed)"
        totalCountries.text = "\(countries.count)"
        
        return cell

    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.covidCase = countries[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
   
}

