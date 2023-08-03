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


class MapViewController: UIViewController, CLLocationManagerDelegate, CreateNewListingDelegate, MKMapViewDelegate {
    
    

    
    
    @IBOutlet weak var mapView: MKMapView!
    let listingModel = ListingModel.getSharedInstance()
    let foodStopModel = FoodStopModel.getSharedInstance()
    let locationManager = CLLocationManager()
    let session = URLSession.shared
    let listing : Listing! = nil
    public var createNewListingDelegate : CreateNewListingDelegate?
    @IBOutlet weak var controlsContainer: UIView!
    
    var foodStops:[FoodStop] = []
    
    override func viewWillAppear(_ animated: Bool) {
        foodStopModel.loadManagedFoodStops { (completed) in
            DispatchQueue.main.async {
                if (self.foodStopModel.managedFoodStops.count > 0) {
                    self.controlsContainer.isHidden = false
                }
                else {
                    self.controlsContainer.isHidden = true
                }
            }
            
        }
        
        foodStopModel.loadFoodStops { (completed) in
            self.foodStops = self.foodStopModel.foodStops
            
            for foodStop in self.foodStops{
                
                let foodStopCoordinates = CLLocationCoordinate2D(latitude: foodStop.lat,longitude: foodStop.lng)
                
                let anno = MKPointAnnotation()
                anno.coordinate = foodStopCoordinates
                
                anno.title = foodStop.name
                anno.subtitle = foodStop.description
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(anno)
                }
            }
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation") as? MKMarkerAnnotationView {
            view = dequeuedView
        }
        else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier:"annotation")
        }
        
  
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        var color = "#FFFFFF"
        for foodStop in foodStops {
            if foodStop.name == annotation.title {
                color = foodStop.hexColor
                view.glyphText = String(foodStop.name.prefix(2).uppercased())
            }
        }
   
        view.markerTintColor = UIColor(hexaRGB: color)
        
        return view
    }
    
    func didComplete() {
        listingModel.loadListings {  (completed, status) in
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
        
        
        let initialLocation = CLLocationCoordinate2D(latitude: 41.372442, longitude: -81.850165)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.0070,longitudeDelta: 0.0070)
        let region = MKCoordinateRegion(center:initialLocation, span: span)
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
        
        
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
