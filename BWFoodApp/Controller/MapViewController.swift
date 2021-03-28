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
    let foodStopModel = FoodStopModel.getSharedInstance()
    let locationManager = CLLocationManager()
    let session = URLSession.shared
    let listing : WSListing! = nil
    public var createNewListingDelegate : CreateNewListingDelegate?
    @IBOutlet weak var controlsContainer: UIView!
    
    var foodStops:[FoodStop]!
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async { [self] in
            foodStopModel.loadFoodStops { (completed) in
                foodStops = foodStopModel.foodStops
                
                for foodStop in foodStops{
    
                    let foodStopCoordinates = CLLocationCoordinate2D(latitude: foodStop.lat,longitude: foodStop.lng)
                    let anno = MKPointAnnotation()
                    anno.coordinate = foodStopCoordinates
                    anno.title = foodStop.name
                    
                    DispatchQueue.main.async {
                        mapView.addAnnotation(anno)
                    }
                    
                    
                }
            }
        }
        
    }
    
    func didComplete() {
        listingModel.loadListings {  (completed) in
            DispatchQueue.main.async {
                
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
        
        let initialLocation = CLLocationCoordinate2D(latitude: 41.3692, longitude: -81.8486)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.0050,longitudeDelta: 0.0050)
        let region = MKCoordinateRegion(center:initialLocation, span: span)
        mapView.setRegion(region, animated: true)
        
        
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
