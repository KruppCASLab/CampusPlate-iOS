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

class MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, CreateNewListingDelegate{
    

    @IBOutlet weak var listingsLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var postListingButton: UIButton!
    
    
    @IBAction func postListingScreen(_ sender: Any) {
        
        performSegue(withIdentifier: "createListingScreen", sender: self)
        
    }

//    @IBAction func addListing(_ sender: Any) {
//    performSegue(withIdentifier: "addScreen", sender: self)
//    }
    
    
    
    let listingModel = ListingModel.getSharedInstance()
    
    var indexSelected:IndexPath?
    
    let locationManager = CLLocationManager()
    
    let session = URLSession.shared
    
    let listing : WSListing! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
        
        //Show Pins on Map
        for i in 0 ..< listingModel.getNumberOfListings() {
            
            let listing2 = listingModel.getListing(index: i)
            
            let mapAnnotation = MKPointAnnotation()
            mapAnnotation.title = listing2.title
            mapAnnotation.subtitle = listing2.locationDescription
            mapAnnotation.coordinate = CLLocationCoordinate2DMake(listing2.lat!, listing2.lng!)
            
            mapView.addAnnotation(mapAnnotation)
            
        }
        
        listingModel.loadListings { (completed) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        listingsLabel.layer.borderWidth = 1
        listingsLabel.layer.borderColor = UIColor.systemOrange.cgColor
        tableView.separatorColor = .systemOrange
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingModel.getNumberOfListings()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:FoodListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodListingCell", for: indexPath) as! FoodListingTableViewCell
        var listing:WSListing = listingModel.getListing(index: indexPath.row)
        
        cell.food.text = listing.title ?? "Food"
    
        return cell
        
    }
    
    func didComplete() {
        listingModel.loadListings { (completed) in
            DispatchQueue.main.async {
                //TODO: Create annotation
                self.tableView.reloadData()
            }
        }
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
        else if let createVc = segue.destination as? CreateNewListing {
            createVc.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = indexPath
        self.performSegue(withIdentifier: "showFoodPickupDetail", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postListingButton.layer.cornerRadius = 15
        
        tableView.separatorColor = .systemOrange
        
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
