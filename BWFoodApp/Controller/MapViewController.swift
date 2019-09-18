//
//  mapViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/25/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation

class MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func addListing(_ sender: Any) {
    performSegue(withIdentifier: "addScreen", sender: self)
    }
    
    let listingModel = ListingModel.getSharedInstance()
    
    var indexSelected:IndexPath?
    
    let locationManager = CLLocationManager()
    
    let session = URLSession.shared
    
    override func viewWillAppear(_ animated: Bool) {
        
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
        
        //Show Pins on Map
        for i in 0 ..< listingModel.getNumberOfListings() {
            
            let listing = listingModel.getListing(index: i)
        
            //mapView.addAnnotation(listing)
            
        }
        
        listingModel.loadListings { (completed) in
            self.tableView.reloadData()
        }
        //self.tableView.reloadData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingModel.getNumberOfListings()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:FoodListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodListingCell", for: indexPath) as! FoodListingTableViewCell
        var listing:WSListing = listingModel.getListing(index: indexPath.row)
        
        cell.food.text = listing.title!
    
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
                foodVC.indexPathOfListing = indexPath
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = indexPath
        self.performSegue(withIdentifier: "showFoodPickupDetail", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapType = .satelliteFlyover
        

        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        
        locationManager.delegate = self

        // Do any additional setup after loading the view.
        
        // Set initial location in Berea
        let initialLocation = CLLocationCoordinate2D(latitude: 41.371039, longitude: -81.847857)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.008,longitudeDelta: 0.008)
        let region = MKCoordinateRegion(center:initialLocation, span: span)
        mapView.setRegion(region, animated: true)
    
    }
    
    //var locations = [CLCircularRegion]()
    
    func setUpGeofenceForMaCS() {
        let geofenceRegionCenter = CLLocationCoordinate2DMake(41.370600, -81.848127);
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 74, identifier: "MaCS")
        geofenceRegion.notifyOnExit = true
        geofenceRegion.notifyOnEntry = true
        self.locationManager.startMonitoring(for: geofenceRegion)
        //locations.append(geofenceRegion)
    }
    func setUpGeofenceForHiggins() {
        let geofenceRegionCenter = CLLocationCoordinate2DMake(41.371816, -81.847962);
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 85, identifier: "Lou Higgins")
        geofenceRegion.notifyOnExit = true
        geofenceRegion.notifyOnEntry = true
        self.locationManager.startMonitoring(for: geofenceRegion)
        //locations.append(geofenceRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region.identifier == "MaCS"{
             print("Welcome to MaCS!")
        }else if region.identifier == "Lou Higgins"{
            print("Welcome to Lou Higgins!")
        }
       
        //Good place to schedule a local notification
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Bye! Hope you had a great day at MaCS")
        //Good place to schedule a local notification
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedAlways) {
            self.setUpGeofenceForMaCS()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
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
