//
//  mapViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/25/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var mapView: MKMapView!
    
    let listingModel = ListingModel.getSharedInstance()
    
    var indexSelected:IndexPath?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingModel.getNumberOfListings()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:FoodListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodListingCell", for: indexPath) as! FoodListingTableViewCell
        var listing:Listing = listingModel.getListing(index: indexPath.row)
        
        cell.food.text = listing.food
        cell.time.text = listing.time
        cell.location.text = listing.location
    
        return cell
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Grab the food item selected and populate the next screen
        if let foodVC = segue.destination as? PickUpFoodViewController {
            if let indexPath = indexSelected {
                let listing = self.listingModel.getListing(index: indexPath.row)
                foodVC.listing = listing
            }
            
        }
    }
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set initial location in Berea
        let initialLocation = CLLocationCoordinate2D(latitude: 41.371039, longitude: -81.847857)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.008,longitudeDelta: 0.008)
        let region = MKCoordinateRegion(center:initialLocation, span: span)
        mapView.setRegion(region, animated: true)
        

        
        
        // Show pin on map
        
        for i in 0 ..< listingModel.getNumberOfListings() {
            let listing = listingModel.getListing(index: i)
            mapView.addAnnotation(listing)
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = indexPath
        self.performSegue(withIdentifier: "showFoodPickupDetail", sender: self)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapVC = sender as? pickUpFoodViewController {
            
            if let
        }
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
