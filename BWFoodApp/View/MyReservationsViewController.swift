//
//  MyReservationsViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 3/4/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import UIKit

class MyReservationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let reservationModel = ReservationModel.getSharedInstance()
    
    var reservations = [Reservation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reservationModel.getUserReservations { [self] (completed) in
            reservations = reservationModel.reservations
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell:MyReservationsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reservationCell", for: indexPath) as! MyReservationsTableViewCell
            
            let reservation:Reservation = reservationModel.getReservation(index: indexPath.row)
            
            cell.reservationCode.text = "RESERVATION CODE: " + String(reservation.code!)
            
            return cell
            
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
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
