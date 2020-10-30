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


class MapViewController: UIViewController,CLLocationManagerDelegate, CreateNewListingDelegate{
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let listingModel = ListingModel.getSharedInstance()
    
    let locationManager = CLLocationManager()
    
    let session = URLSession.shared
    
    let listing : WSListing! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        
        listingModel.loadListings { (completed) in
            DispatchQueue.main.async {
                
                self.refreshMap()


            }
        }
    }
    
    
    func refreshMap(){
        for annotation in self.mapView.annotations {
                         self.mapView.removeAnnotation(annotation)
                     }
                     
                     //Show Pins on Map
                     for i in 0 ..< self.listingModel.getNumberOfListings() {
                         
                         let listing2 = self.listingModel.getListing(index: i)
                         
                         let mapAnnotation = MKPointAnnotation()
                         mapAnnotation.title = listing2.title
                         mapAnnotation.subtitle = listing2.locationDescription
                         mapAnnotation.coordinate = CLLocationCoordinate2DMake(listing2.lat!, listing2.lng!)
                         
                         self.mapView.addAnnotation(mapAnnotation)
                         
                     }
    }
    
    func didComplete() {
        listingModel.loadListings { (completed) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                self.refreshMap()
            }
        }
    }
    
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "goToListingScreen" {
//            return true
//        }
//        return false
//    }

    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO: Fix me
        //loadingIndicator.loadGif(name: "fork-and-knife-logo")
        
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
}
