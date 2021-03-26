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
    public var createNewListingDelegate : CreateNewListingDelegate?
    @IBOutlet weak var controlsContainer: UIView!

    override func viewWillAppear(_ animated: Bool) {
        
        listingModel.loadListings { (completed) in
            DispatchQueue.main.async {
                
                //self.refreshMap()


            }
        }
    }
    
    func didComplete() {
        listingModel.loadListings {  (completed) in
            DispatchQueue.main.async {
                
                //self.refreshMap()
            }
            
            if let delegate = self.createNewListingDelegate {
                delegate.didComplete()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addListingSegue") {
            if let vc = segue.destination as? UINavigationController {
                if let addVc:CreateNewListing = vc.viewControllers[0] as? CreateNewListing {
                    addVc.delegate = self
                }
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlsContainer.layer.cornerRadius = 10.0
   
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        let initialLocation = CLLocationCoordinate2D(latitude: 41.371039, longitude: -81.847857)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.010,longitudeDelta: 0.010)
        let region = MKCoordinateRegion(center:initialLocation, span: span)
            mapView.setRegion(region, animated: true)

        
        let knowltonCenter = MKPointAnnotation()
        knowltonCenter.title = "The Knowlton Center"
        knowltonCenter.coordinate = CLLocationCoordinate2D(latitude: 41.374858, longitude: -81.851229)
        mapView.addAnnotation(knowltonCenter)
        
        let veteransCenter = MKPointAnnotation()
        veteransCenter.title = "The Veterans Center"
        veteransCenter.coordinate = CLLocationCoordinate2D(latitude: 41.369901, longitude: -81.849166)
        mapView.addAnnotation(veteransCenter)
        
        let unionDiningHall = MKPointAnnotation()
        unionDiningHall.title = "The Union Dining Hall"
        unionDiningHall.coordinate = CLLocationCoordinate2D(latitude: 41.369176, longitude: -81.848572)
        mapView.addAnnotation(unionDiningHall)
    
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard annotation is MKPointAnnotation else { return nil }
//
//        let identifier = "Annotation"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView!.canShowCallout = true
//        } else {
//            annotationView!.annotation = annotation
//        }
//
//        return annotationView
//    }
    
    
    
    
    
}
