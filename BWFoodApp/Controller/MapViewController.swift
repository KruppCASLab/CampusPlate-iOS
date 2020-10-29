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

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let listingModel = ListingModel.getSharedInstance()
    
    var indexSelected:IndexPath?
    
    let locationManager = CLLocationManager()
    
    let session = URLSession.shared
    
    let listing : WSListing! = nil
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var gripperView: UIView!
    
    @IBOutlet var topSeparatorView: UIView!
    @IBOutlet var bottomSeperatorView: UIView!
    
    @IBOutlet weak var gripperTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet var headerSectionHeightConstraint: NSLayoutConstraint!
    
   
    @IBOutlet weak var loadingIndicator: UIImageView!
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            
            // We'll configure our UI to respect the safe area. In our small demo app, we just want to adjust the contentInset for the tableview.
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        listingModel.loadListings { (completed) in
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                self.refreshMap()
    
                self.loadingIndicator.isHidden = true

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
                self.navigationController?.popViewController(animated: true)
                self.tableView.reloadData()
                self.refreshMap()
            }
        }
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goToListingScreen" {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Grab the food item selected and populate the next screen
        
        if let foodVC = segue.destination as? PickUpFoodViewController {
            if let indexPath = indexSelected {
                let listing = self.listingModel.getListing(index: indexPath.row)
                foodVC.listing = listing
                foodVC.indexPathOfListing = indexPath
                foodVC.delegate = self
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = indexPath
        self.performSegue(withIdentifier: "showFoodPickupDetail", sender: self)
        
        let primaryContent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickUpFoodViewController")

        pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)

        pulleyViewController?.setPrimaryContentViewController(controller: primaryContent, animated: false)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // The bounce here is optional, but it's done automatically after appearance as a demonstration.
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(bounceDrawer), userInfo: nil, repeats: false)
    }
    
    @objc fileprivate func bounceDrawer() {
        
        // We can 'bounce' the drawer to show users that the drawer needs their attention. There are optional parameters you can pass this method to control the bounce height and speed.
        self.pulleyViewController?.bounceDrawer()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gripperView.layer.cornerRadius = 2.5
        
        //TODO: Fix me
        //loadingIndicator.loadGif(name: "fork-and-knife-logo")
        
        tableView.separatorColor = UIColor.init(named: "CampusPlateGreen")
        
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

extension MapViewController: PulleyDrawerViewControllerDelegate {

    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
    
        
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 68.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 264.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
    }
    
    // This function is called by Pulley anytime the size, drawer position, etc. changes. It's best to customize your VC UI based on the bottomSafeArea here (if needed). Note: You might also find the `pulleySafeAreaInsets` property on Pulley useful to get Pulley's current safe area insets in a backwards compatible (with iOS < 11) way. If you need this information for use in your layout, you can also access it directly by using `drawerDistanceFromBottom` at any time.
    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat)
    {
        // We want to know about the safe area to customize our UI. Our UI customization logic is in the didSet for this variable.
        drawerBottomSafeArea = bottomSafeArea
        
        /*
         Some explanation for what is happening here:
         1. Our drawer UI needs some customization to look 'correct' on devices like the iPhone X, with a bottom safe area inset.
         2. We only need this when it's in the 'collapsed' position, so we'll add some safe area when it's collapsed and remove it when it's not.
         3. These changes are captured in an animation block (when necessary) by Pulley, so these changes will be animated along-side the drawer automatically.
         */
        if drawer.drawerPosition == .collapsed
        {
            headerSectionHeightConstraint.constant = 68.0 + drawerBottomSafeArea
        }
        else
        {
            headerSectionHeightConstraint.constant = 68.0
        }
        
        // Handle tableview scrolling / searchbar editing
        
        tableView.isScrollEnabled = drawer.drawerPosition == .open || drawer.currentDisplayMode == .panel
        
        
        if drawer.currentDisplayMode == .panel
        {
            topSeparatorView.isHidden = drawer.drawerPosition == .collapsed
            bottomSeperatorView.isHidden = drawer.drawerPosition == .collapsed
        }
        else
        {
            topSeparatorView.isHidden = false
            bottomSeperatorView.isHidden = true
        }
    }
    
    /// This function is called when the current drawer display mode changes. Make UI customizations here.
    func drawerDisplayModeDidChange(drawer: PulleyViewController) {
        
        print("Drawer: \(drawer.currentDisplayMode)")
        gripperTopConstraint.isActive = drawer.currentDisplayMode == .drawer
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81.0
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let primaryContent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrimaryTransitionTargetViewController")
//
//        pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
//
//        pulleyViewController?.setPrimaryContentViewController(controller: primaryContent, animated: false)
//    }

    
    
}
