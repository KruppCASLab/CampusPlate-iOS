//
//  FoodTableViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/30/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

class FoodTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateNewListingDelegate, PresentingViewControllerDelegate, AppStateObserver {
    
    private var refreshDataTimer:Timer?
    
    // MARK:- Timer Functions
    private func startTimer() {
        refreshDataTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { (timer) in
            self.loadData()
        }
    }
    private func stopTimer() {
        refreshDataTimer?.invalidate()
    }
    
    // MARK:- AppStateObserver Delegate
    func applicationDidBecomeActive() {
        startTimer()
    }
    
    func applicationDidBecomeInactive() {
        stopTimer()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var shouldDisplayCustomMaskExample = false
    
    let listingModel = ListingModel.getSharedInstance()
    
    let foodStopModel = FoodStopModel.getSharedInstance()
    
    var indexSelected:IndexPath?
    
    let session = URLSession.shared
    
    let listing : Listing! = nil
    
    @IBOutlet weak var gripperView: UIView!
    @IBOutlet weak var bottomSeperatorView: UIView!
    @IBOutlet weak var topSeperatorView: UIView!
    
    @IBOutlet weak var gripperTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    var listings:[Listing] = []
    
    func childViewDidComplete() {
        dismiss(animated: true, completion: nil)
        self.loadData()
    }
    
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            
            // We'll configure our UI to respect the safe area. In our small demo app, we just want to adjust the contentInset for the tableview.
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return model + 1 for the resevation, otherwise 2 for reservation and empty state
        if (listingModel.getNumberOfListings() > 0 ) {
            return listingModel.getNumberOfListings() + 1
        }
        else {
            return 2;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        func daysBetween(start: Date, end: Date) -> Double {
            return Double(Calendar.current.dateComponents([.day], from: start, to: end).day!)
        }
        
        if indexPath.row == 0 {
            let cell:ReservationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myReservations", for: indexPath) as! ReservationTableViewCell
            
            cell.colorIndicator.layer.cornerRadius = min(cell.colorIndicator.frame.size.width/2, cell.colorIndicator.frame.size.height/2)
            
            cell.reservationLabel.text = "RESERVATIONS"
            
            return cell
        }
        else if indexPath.row == 1 && listingModel.getNumberOfListings() == 0 {
            let cell:EmptyStateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateTableViewCell
            return cell
  
        }
        else{
            let foodCell:FoodListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodListingCell", for: indexPath) as! FoodListingTableViewCell
            
            let listing:Listing = listingModel.getListing(index: (indexPath.row - 1))

            
            let foodStop = foodStopModel.getFoodStop(foodStopId: listing.foodStopId!)
            
            
            let dateFormatterDate = DateFormatter()
            let dateFormatterTime = DateFormatter()
            
            dateFormatterDate.timeZone = TimeZone(abbreviation: "EDT")
            dateFormatterDate.locale = NSLocale.current
            dateFormatterDate.dateFormat = "M-dd"
            
            dateFormatterTime.timeZone = TimeZone(abbreviation: "EDT")
            dateFormatterTime.locale = NSLocale.current
            dateFormatterTime.dateFormat = "h:MM aa"
            
            if let quantityRemaining = listing.quantityRemaining {
                foodCell.quantityField.text = String(quantityRemaining) + " REMAINING"
            }
            else {
                foodCell.quantityField.text = ""
            }
            
            
            foodCell.foodStopLocationLabel.text = foodStop!.name
            foodCell.foodLabel.text = listing.title?.uppercased()
            foodCell.leftBar.backgroundColor = UIColor(hexaRGB: foodStop!.hexColor)
            
            return foodCell
        }
    }
    
    func didComplete() {
        loadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = indexPath
        self.performSegue(withIdentifier: "showFoodPickupDetail", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gripperView.layer.cornerRadius = 2.5
        tableView.layer.cornerRadius=10
        
        tableView.delegate = self
        tableView.dataSource = self
        
        AppState.shared.addObserver(observer: self)
        startTimer()
    }
    
    private func loadData() {
        foodStopModel.loadFoodStops { (sucess) in
            self.listingModel.loadListings { (result, status) in
                var alertMessage:String?
                
                if (result == false) {
                    alertMessage = "Unable to communicate with Campus Plate. Please check your network connection."
                }
                else if (status == 401) {
                    alertMessage = "Your device can no longer login to the Campus Plate. It is recommended you reset your account."
                }
                
                if let alertMessage = alertMessage {
                    let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
                    
                    if (status == 401) {
                        alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { (action) in
                            KeychainCredentialManager.clearCredentials()
                            self.present(UIAlertController(title: "Completed", message: "Please force close the app to re-register your device.", preferredStyle: .alert), animated: true, completion: nil)
                        }))
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                        }))
                    }
                    else {
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        }))
                    }
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                    
                }
                DispatchQueue.main.async { [self] in
                    self.listings = listingModel.listings
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
        
        pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: false)
        
        // The bounce here is optional, but it's done automatically after appearance as a demonstration.
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(bounceDrawer), userInfo: nil, repeats: false)
        
    }
    
    @objc fileprivate func bounceDrawer() {
        
        // We can 'bounce' the drawer to show users that the drawer needs their attention. There are optional parameters you can pass this method to control the bounce height and speed.
        self.pulleyViewController?.bounceDrawer()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showFoodPickupDetail" {
            
            let navController = segue.destination as! UINavigationController
            
            if let foodVC = navController.topViewController as? PickUpFoodViewController {
                
                if let indexPath = indexSelected {
                    
                    if indexPath.row == 0{
                        
                        self.performSegue(withIdentifier: "myReservations", sender: self)
                    }else{
                        foodVC.presentingDelegate = self;
                        let listing = self.listingModel.getListing(index: indexPath.row - 1)
                        foodVC.listing = listing
                        foodVC.indexPathOfListing = indexPath
                    }
                }
                
            }
        }
        //        if let foodVC = segue.destination as? PickUpFoodViewController {
        //
        //            if let indexPath = indexSelected {
        //
        //                if indexPath.row == 0{
        //
        //                    self.performSegue(withIdentifier: "myReservations", sender: self)
        //                }else{
        //                    let listing = self.listingModel.getListing(index: indexPath.row - 1)
        //                    foodVC.listing = listing
        //                    foodVC.indexPathOfListing = indexPath
        //                }
        //            }
        //
        //        }
    }
    
    
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}

extension FoodTableViewController: PulleyDrawerViewControllerDelegate{
    
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
            headerHeightConstraint.constant = 68.0 + drawerBottomSafeArea
        }
        else
        {
            headerHeightConstraint.constant = 68.0
        }
        
        // Handle tableview scrolling / searchbar editing
        
        tableView.isScrollEnabled = drawer.drawerPosition == .open || drawer.currentDisplayMode == .panel
        
        
        if drawer.currentDisplayMode == .panel
        {
            topSeperatorView.isHidden = drawer.drawerPosition == .collapsed
            bottomSeperatorView.isHidden = drawer.drawerPosition == .collapsed
        }
        else
        {
            topSeperatorView.isHidden = false
            bottomSeperatorView.isHidden = true
        }
    }
    
    /// This function is called when the current drawer display mode changes. Make UI customizations here.
    func drawerDisplayModeDidChange(drawer: PulleyViewController) {
        
        print("Drawer: \(drawer.currentDisplayMode)")
        //        gripperTopConstraint.isActive = drawer.currentDisplayMode == .drawer
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        return tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 58
        }else{
            return 119
        }
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

