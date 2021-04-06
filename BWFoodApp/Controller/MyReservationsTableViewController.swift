//
//  MyReservationsTableViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 3/4/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import UIKit

class MyReservationsTableViewController: UITableViewController {
    
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
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        listingModel.loadListings { [self] (completed) in
            reservationModel.getUserReservations { [self] (completed) in
                DispatchQueue.main.async {
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
        // #warning Incomplete implementation, return the number of rows
        //return reservationModel.getNumberOfReservations()
        return reservations.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell:ReservationsCell = tableView.dequeueReusableCell(withIdentifier: "ReservationsCell") as! ReservationsCell
            
            cell.label?.text = "RESERVATIONS"
            
            return cell
            
        }else{
            let cell:MyReservationsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reservationCell", for: indexPath) as! MyReservationsTableViewCell
            
            let reservation:Reservation = reservations[indexPath.row - 1]
            
            let unixTimestamp = reservation.timeExpired
            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp!))
            
            let currentDate = Date()
            func minutesTillExpiration(start: Date, end: Date) -> Int {
                return Calendar.current.dateComponents([.minute], from: start, to: end).minute!
            }
            
            let listing = listingModel.getListingById(listingId: reservation.listingId!)
            
            let foodStop:FoodStop = foodStopModel.getFoodStop(foodStopId: listing!.foodStopId!)!
            
            cell.foodName.text = listing!.title
            cell.foodStopLocation.text = foodStop.name
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Specify your format that you want
            
            let minutes = minutesTillExpiration(start: currentDate, end: date)
            let minutesTillExp = String(minutes)
            
            let strDate = dateFormatter.string(from: date)
            
            cell.expiresLabel.text = "Expires in: " + minutesTillExp + " minutes"
            
            cell.foodStopColor.backgroundColor = UIColor(hexaRGB: foodStop.hexColor)
            cell.reserved.text = "Reserved " + String(reservation.quantity!)
            cell.reservationCode.text = "Reservation Code: " + String(reservation.code!)
            
            listingModel.getImage(listingId: listing!.listingId!) { (data) in
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 60
        }else{
            return 176
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
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
