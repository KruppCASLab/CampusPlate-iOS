//
//  MyReservationsTableViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 3/4/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import UIKit

class MyReservationsTableViewController: UITableViewController{
    
    let reservationModel = ReservationModel.getSharedInstance()
    let foodStopModel = FoodStopModel.getSharedInstance()
    let listingModel = ListingModel.getSharedInstance()
    
    
    var reservations = [Reservation]()
    var listings = [Listing]()
    
    var minutes:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //activityView.startAnimating()
        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listingModel.loadListings { [self] (completed, status) in
            reservationModel.getUserReservations { [self] (completed) in
                DispatchQueue.main.async { [self] in
                    reservations = reservationModel.reservations
                    listings = listingModel.listings
                    
                    //activityView.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Return the title row
        if indexPath.row == 0 {
            let cell:ReservationTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReservationTitleCell") as! ReservationTitleTableViewCell
            return cell
            
        }
        else{
            let cell:MyReservationsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as! MyReservationsTableViewCell
            
            let reservation:Reservation = reservations[indexPath.row - 1]
            
            guard let listingId = reservation.listingId else {
                cell.foodName.text = "Error: Unable to load reservation listing, please try again."
                return cell
            }
                        
            let unixTimestamp = reservation.timeExpired
            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp!))
            
            let currentDate = Date()
            func minutesTillExpiration(start: Date, end: Date) -> Int {
                return Calendar.current.dateComponents([.minute], from: start, to: end).minute!
            }
            
            guard let listing = listingModel.getListingById(listingId: listingId), let foodStopId = listing.foodStopId else {
                cell.foodName.text = "Error: Unable to load reservation listing, please try again."
                return cell
            }
            
            guard let foodStop:FoodStop = foodStopModel.getFoodStop(foodStopId: foodStopId) else {
                cell.foodName.text = "Error: Unable to load food stop of listing, please try again."
                return cell
            }
            
            cell.foodName.text = listing.title
            cell.foodStopLocation.text = foodStop.name
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Specify your format that you want
            
            let minutes = minutesTillExpiration(start: currentDate, end: date)
            let minutesTillExp = String(minutes)
            
            
            
            cell.expiresLabel.text = "Expires in: " + minutesTillExp + " minutes"
            
            cell.foodStopColor.backgroundColor = UIColor(hexaRGB: foodStop.hexColor)
            cell.reserved.text = "Reserved " + String(reservation.quantity!)
            cell.reservationCode.text = "Reservation Code: " + String(reservation.code!)
            
            listingModel.getImage(listingId: listingId) { (data) in
                DispatchQueue.main.async {
                    if !data.isEmpty{
                        let decodedImage = UIImage(data: data)
                        cell.foodImageVIew.image = decodedImage
                    }else{
                        
                    }
                }
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row > 0) {
            return true
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let deleteConfirmationAlert = UIAlertController(title: "Delete Reservation", message: "Are you sure you want to delete this reservation?", preferredStyle: .actionSheet)
            
            deleteConfirmationAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
                (alert:UIAlertAction!) in
                self.reservationModel.deleteUserReservations(reservationId: self.reservations[indexPath.row - 1].reservationId!) { success in
                    if (success) {
                        DispatchQueue.main.async {
                            tableView.deleteRows(at: [indexPath], with: .left)
                        }
                        self.reservations.remove(at: indexPath.row - 1)
                        
                    } else {
                        // if an error occurs while trying to delete reseravtion
                        DispatchQueue.main.async {
                            
                            let failAlert = UIAlertController(title: "An Error Occured", message: "Please try again.", preferredStyle: .alert)
                            
                            failAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                            
                            self.present(failAlert, animated: true, completion: nil)
                        }
                    }
                    DispatchQueue.main.async {
                        
                        let successAlert = UIAlertController(title: "Reservation Deleted", message: "You have cancelled and deleted this reservation.", preferredStyle: .alert)
                        
                        successAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        
                        self.present(successAlert, animated: true, completion: nil)
                    }
                }
                
            }))
            deleteConfirmationAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(deleteConfirmationAlert, animated: true, completion: nil)
            
        }
    }
}
