//
//  DrawerContentViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/26/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

class DrawerContentViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var indexSelected:IndexPath?
    
    let listingModel = ListingModel.getSharedInstance()
    
    override func viewWillAppear(_ animated: Bool) {
        
        listingModel.loadListings { (completed) in
            DispatchQueue.main.async {
                
                self.tableView.reloadData()

            }
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
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
    
    extension DrawerContentViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 81.0
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            let primaryContent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickUpFoodViewController")

            pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)

            pulleyViewController?.setPrimaryContentViewController(controller: primaryContent, animated: false)
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

