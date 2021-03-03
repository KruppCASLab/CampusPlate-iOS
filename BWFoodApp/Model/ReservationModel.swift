//
//  ReservationModel.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/25/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

class ReservationModel {
    
    private var reservations = Array<Reservation>()
    
    private let url = URL(string: "https://mopsdev.bw.edu/food/rest.php/reservations")
    
    private static let sharedInstance = ReservationModel()
    let session = URLSession.shared
    
    static public func getSharedInstance() -> ReservationModel {
        return self.sharedInstance
    }
    
    public func addReservation(reservation:Reservation, completion:@escaping (ReservationResponse)->Void) {
        
        self.reservations.append(reservation)
        var request = URLRequest(url: self.url!)
        
        request.httpMethod = "POST"
        
        request = RequestUtility.addAuth(original: request)
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do {
            let data = try encoder.encode(reservation)
            session.uploadTask(with: request, from: data) { (data, response, error) in
                do {
                    let reservationResponse = try decoder.decode(ReservationResponse.self, from: data!)
                    completion(reservationResponse)
                }
                catch {
                    
                }
            }.resume()
            
        }
        catch {
            
        }
        
    }
    
}
