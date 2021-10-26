import Foundation
import MapKit

class ListingModel {
    
    public var listings = Array<Listing>()
    
    private let url = URL(string: ServiceClient.serviceClientUrl() + "/listings")
    
    private static let sharedInstance = ListingModel()
    let session = URLSession.shared
    
    static public func getSharedInstance() -> ListingModel {
        return self.sharedInstance
    }
    
    public func loadListings(completion:@escaping (Bool, Int?)->Void) {
        
        var request = URLRequest(url: self.url!)
        
        request.httpMethod = "GET"
        request = RequestUtility.addAuth(original: request)
        
        session.dataTask(with: request){ (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if (response.statusCode == 401) {
                    completion(false, 401)
                }
            }
            
            guard let data = data else {
                completion(false, 0)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ListingResponse.self, from: data)
                guard let responseData = response.data else {
                    completion(false, 0)
                    return
                }
        
                self.listings = responseData
                completion(true, 0)
            
            }
            catch {
                completion(false, 0)
            }
            
        }.resume()
    }
    
    public func getImage(listingId: Int, completion:@escaping (Data)-> Void){
        let imageURL = (self.url?.appendingPathComponent("/" + String(listingId) + "/image"))!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        request = RequestUtility.addAuth(original: request)
        
        session.dataTask(with: request){ (data, response, error) in
            guard let data = data else {
//                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(ImageResponse.self, from: data)
                
                guard let responseData = response.data else {
//                    completion(false)
                    return
                }
                let imageString = responseData
                
                if let decodedData = Data(base64Encoded: imageString) {
                    completion(decodedData)
                }
            }
            catch{
                
            }
        }.resume()
    }

    public func update() {
        //TODO: Call service client to update
    }
    
    public func getListing(index:Int) -> Listing {
        return self.listings[index]
    }
    
    public func addListing(listing:Listing, completion:@escaping (Bool)->Void) {
        self.listings.append(listing)
        var request = URLRequest(url: self.url!)
        
        request.httpMethod = "POST"
        
        request = RequestUtility.addAuth(original: request)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(listing)
            session.uploadTask(with: request, from: data) { (data, response, error) in
                completion(true)
            }.resume()
        }
        catch {
            
        }
    }
    
    public func getNumberOfListings() -> Int {
        return self.listings.count
    }
    
    public func getListingById(listingId: Int) -> Listing? {
        for listing in self.listings {
            if listing.listingId == listingId {
                return listing
            }
        }
    
        return nil
    }
    
    
}
