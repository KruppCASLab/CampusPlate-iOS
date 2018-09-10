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
    
    var food = ["Pizza", "Subs", "Cookies", "Salad", "Soda", "Chips"] 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:FoodListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodListingCell", for: indexPath) as! FoodListingTableViewCell
        cell.food.text = food[indexPath.row]
       
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let selectedFoodItem = food[indexPath.row]
//        performSegue(withIdentifier: "moveToPickUpScreen", sender: selectedFoodItem )
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Grab the food item selected and populate the next screen
        if let foodVC = segue.destination as? PickUpFoodViewController {
            
//            if let selectedFoodItem = sender as? String {
//                foodVC.foodPickUp = selectedFoodItem
//            }
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
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation
        annotation.title = "Berea"
        annotation.subtitle = "Baldwin Wallace"
        
        
        
        // Show pin on map
        
        let pizza = FoodPickUpSites(title: "Pizza", locationName: "Math and computer Science", discipline: "Lounge", coordinate: CLLocationCoordinate2D(latitude: 41.3708812, longitude: -81.8478923))
        mapView.addAnnotation(pizza)
        
        let subs = FoodPickUpSites(title: "Subs", locationName: "Kamm Hall", discipline: "Business Lounge", coordinate: CLLocationCoordinate2D(latitude: 41.3684241, longitude: -81.8439512))
        mapView.addAnnotation(subs)
        
        let cookies = FoodPickUpSites(title: "Cookies", locationName: "Lou Higgins Center", discipline: "Tressel Lounge", coordinate: CLLocationCoordinate2D(latitude: 41.3719144, longitude: -81.8478714))
        mapView.addAnnotation(cookies)
        
        let salad = FoodPickUpSites(title: "Salads", locationName: "Ritter Library", discipline: "3rd Floor Lounge", coordinate: CLLocationCoordinate2D(latitude: 41.3732252, longitude: -81.8509172))
        mapView.addAnnotation(salad)
        
        let chips = FoodPickUpSites(title: "Chips", locationName: "The Union", discipline: "Cyber", coordinate: CLLocationCoordinate2D(latitude: 41.3692863, longitude: -81.8478429))
        mapView.addAnnotation(chips)
    }
    
    /*
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFoodItem = food[indexPath.row]
        performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
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
