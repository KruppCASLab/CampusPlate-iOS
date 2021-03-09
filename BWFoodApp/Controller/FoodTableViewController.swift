//
//  FoodTableViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/30/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

class FoodTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateNewListingDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var shouldDisplayCustomMaskExample = false
    
    let listingModel = ListingModel.getSharedInstance()
    
    let foodStopModel = FoodStopModel.getSharedInstance()
    
    var indexSelected:IndexPath?
    
    let session = URLSession.shared
    
    let listing : WSListing! = nil
    
    @IBOutlet weak var gripperView: UIView!
    @IBOutlet weak var bottomSeperatorView: UIView!
    @IBOutlet weak var topSeperatorView: UIView!
    
    @IBOutlet weak var gripperTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            
            // We'll configure our UI to respect the safe area. In our small demo app, we just want to adjust the contentInset for the tableview.
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingModel.getNumberOfListings()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > 0 {
            let foodCell:FoodListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodListingCell", for: indexPath) as! FoodListingTableViewCell
            
            let listing:WSListing = listingModel.getListing(index: indexPath.row)
            
            let foodStop = foodStopModel.getFoodStop(foodStopId: listing.foodStopId!)
            foodCell.foodStopLocationLabel.text = foodStop!.name
            foodCell.foodLabel.text = listing.title?.uppercased()
            foodCell.leftBar.backgroundColor = UIColor(hexaRGB: foodStop!.hexColor)
            
            return foodCell
        }
        
        let cell:ReservationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myReservations", for: indexPath) as! ReservationTableViewCell
        
        cell.reservationLabel.text = "RESERVATIONS"
        
        return cell
        
    }
    
    func didComplete() {
        loadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = indexPath
        self.performSegue(withIdentifier: "showFoodPickupDetail", sender: self)
        
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        if indexPath.row > 0{
//            return 137
//        }else{
//            return 50
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gripperView.layer.cornerRadius = 2.5
        tableView.layer.cornerRadius=10
        
        //TODO: Fix me
        //loadingIndicator.loadGif(name: "fork-and-knife-logo")
        
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        foodStopModel.loadFoodStops { (sucess) in
            self.listingModel.loadListings { (result) in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
        
        
        
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
        
        
        if let foodVC = segue.destination as? PickUpFoodViewController {
            if let indexPath = indexSelected {
                let listing = self.listingModel.getListing(index: indexPath.row)
                foodVC.listing = listing
                foodVC.indexPathOfListing = indexPath
            }
        }
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
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
        return 125
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

