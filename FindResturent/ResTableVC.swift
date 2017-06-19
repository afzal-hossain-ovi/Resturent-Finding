//
//  ResTableVC.swift
//  FindResturent
//
//  Created by Md AfzaL Hossain on 3/19/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import Firebase

class ResTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cityModel = [CityModel]()

    @IBOutlet weak var navTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.alpha = 0
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            let user = value["user"] as! NSDictionary
            let key = user.allKeys
            for id in key {
                let singleUser = user[id] as! NSDictionary
                self.navTitle.title = singleUser["username"] as? String
            }
        })
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchCity(title: searchBar.text!)
        searchBar.text = ""
        tableView.alpha = 1
    }
    
    func searchCity(title: String) {
        if let cityName = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+\(cityName)&key=AIzaSyCzX0-efrcBXvxlKSWRIExNhbiAW_U59b0")
            let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else {
                    if data != nil {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            let results = jsonResult["results"] as? NSArray
                            for result in results! {
                                let jsonDick = result as? NSDictionary
                                if let name = jsonDick?["name"] as? String {
                                    if let placeID = jsonDick?["place_id"] as? String {
                                        if let formattedAddress = jsonDick?["formatted_address"] as? String {
                                                if let rating = jsonDick?["rating"] as? Double {
                                                if let openDetails = jsonDick?["opening_hours"] as? NSDictionary {
                                                    if let openInfo = openDetails["open_now"] as? Bool {
                                                        let dataModel = CityModel(name: name, address: formattedAddress, openInfo: String(openInfo), rating: rating, placeId: placeID)
                                                        self.cityModel.append(dataModel)
                                                        print(self.cityModel.count)
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                                
                                DispatchQueue.main.async(execute: {
                                    self.tableView.reloadData()
                                })
                            }
                            
                        }catch {
                            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                }
            }
            dataTask.resume()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cityModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CityTableCell {
            cell.configureCell(cityModel: cityModel[indexPath.row])
            return cell
        }else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailsVC", sender: cityModel[indexPath.row])
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            if let detailsVC = segue.destination as? DetailsVC {
                if let model = sender as? CityModel {
                    detailsVC.cityModel = model
                }
            }
        }
    }
}
