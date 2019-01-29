//
//  CreateNewListing.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/30/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CreateNewListing: UIViewController,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate{
    
    
    
    
    var isDateShowing = false
    
    var interestedCell:ShowTimeCell?
    
    var foodCell:CustomTableViewCell?
    var locationCell:CustomTableViewCell?
   
    
    let listingModel = ListingModel.getSharedInstance()
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        let food = foodCell?.textInputField.text
        let location = locationCell?.textInputField.text
        
        let listing = Listing(food:food ?? "food", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), time: "9:41", location:location ?? "location")
        
        listingModel.addListing(listing: listing)
        
        let numListings = listingModel.getNumberOfListings()
        print(numListings)
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        if (self.isDateShowing) {
            interestedCell?.showTimeLabel.textColor = .blue
            return 4
        }
        else {
            interestedCell?.showTimeLabel.textColor = .black
            return 3
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
            self.foodCell = cell as? CustomTableViewCell
            self.foodCell?.cellLabel.text = "Food: "
            
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
            self.locationCell = cell as? CustomTableViewCell
            self.locationCell?.cellLabel.text = "Location: "
            
            return cell
        }else if(indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as! ShowTimeCell
            
            self.interestedCell = cell
            
            cell.textLabel?.text = "Time: "
            
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! DatePickerTableViewCell
            
            if let interestedCell = self.interestedCell {
                cell.interestedCell = interestedCell
            }
            
            
            return cell
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 2) {
            let indexPath = IndexPath(row: 3, section: 0)
            if (!self.isDateShowing) {
                self.isDateShowing = true
                tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.middle)
                tableView.setNeedsUpdateConstraints()
            }
            else {
                self.isDateShowing = false
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.middle)
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
