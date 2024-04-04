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
// TODO: find a way to have both the add listing button AND enable the userLocation button on the map

class MapViewController: UIViewController, CLLocationManagerDelegate, CreateNewListingDelegate, MKMapViewDelegate, LocationManagerDelegate {
    
    func receiveLocation(location: CLLocation) {
        currentLocation = location
    }
    
    @IBOutlet weak var mapView: MKMapView!
    let listingModel = ListingModel.getSharedInstance()
    let foodStopModel = FoodStopModel.getSharedInstance()
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
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
        foodStopModel.loadFoodStops { [self] (completed) in
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
        var found = false
        for foodStop in foodStops {
            if foodStop.name == annotation.title {
                color = foodStop.hexColor
                view.glyphText = String(foodStop.name.prefix(2).uppercased())
                found = true
            } else {
                
            }
        }
   
        view.markerTintColor = UIColor(hexaRGB: color)
        if (found) {
            return view
        } else {
            return nil
        }
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        currentLocation = location
    }

   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       print("Location manager failed with error: \(error.localizedDescription)")
       // TODO: Handle the error
   }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 1
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        controlsContainer.layer.cornerRadius = 10.0
        
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
                
        if let location = locationManager.location {
            let initialLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.0070, longitudeDelta: 0.0070)
            let region = MKCoordinateRegion(center: initialLocation, span: span)
            mapView.setRegion(region, animated: true)
        }
        
        mapView.delegate = self
        mapView.userTrackingMode = .follow
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                showLocationAccessDeniedAlert()
            case .authorizedWhenInUse:
                break
            @unknown default:
                fatalError("Unknown case when handling location authorization status.")
            }
        }

    private func showLocationAccessDeniedAlert() {
        let alertController = UIAlertController(
            title: "Location Access Denied",
            message: "Please enable location access in Settings. Campus Plate is unable to offer Self-Serve Food Stops until location access is allowed.",
            preferredStyle: .alert
        )
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

