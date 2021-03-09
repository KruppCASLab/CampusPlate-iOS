//
//  ReservationModel.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/25/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

class ReservationModel {
    
    public var reservations = Array<Reservation>()
    
    private let url = URL(string: "https://mopsdev.bw.edu/food/rest.php/reservations")
    
    private static let sharedInstance = ReservationModel()
    let session = URLSession.shared
    
    static public func getSharedInstance() -> ReservationModel {
        return self.sharedInstance
    }
    
    public func getUserReservations(completion:@escaping (Bool)->Void){
            
            var request = URLRequest(url: self.url!)
            
            request.httpMethod = "GET"
            request = RequestUtility.addAuth(original: request)
            
            session.dataTask(with: request){ (data, response, error) in
                
                let decoder = JSONDecoder()
                
                do {
                    let jsonString = String(data: data!, encoding: .utf8)
                    let response = try decoder.decode(GetReservationResponse.self, from: data!)
                    self.reservations = response.data!
                    completion(true)
                }
                catch {
                    
                }
                
            }.resume()
        }
    
    public func addReservation(reservation:Reservation, completion:@escaping (CreateReservationResponse)->Void) {
        
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
                    let reservationResponse = try decoder.decode(CreateReservationResponse.self, from: data!)
                    completion(reservationResponse)
                }
                catch {
                    
                }
            }.resume()
            
        }
        catch {
            
        }
        
    }
    
    public func getReservation(index:Int) -> Reservation {
        return self.reservations[index]
    }
    
    public func getNumberOfReservations() -> Int {
        return self.reservations.count
    }
    
    public func getReservation(reservationId: Int) -> Reservation? {
        for reservation in self.reservations {
            if reservation.reservationId == reservationId {
                return reservation
            }
        }
    
        return nil
    }
    
}
