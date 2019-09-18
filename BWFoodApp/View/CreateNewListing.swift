//
//  CreateNewListing.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/30/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CreateNewListing: UIViewController,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var postListing: UIBarButtonItem!
    
    var foodCell:CustomTableViewCell?
    var locationCell:CustomTableViewCell?
    var quantityCell:StepperTableViewCell?
    var camCell:CameraCell?
    
    
    let listingModel = ListingModel.getSharedInstance()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
        }
    }
    
    @IBAction func quanValue(_ sender: UIStepper) {
        quantityCell?.quantityValue.text = String(sender.value)
    }
    
    @IBAction func cancelListing(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("cancelled")
    }
    
    @IBAction func TakePicture(_ sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.camera
        image.allowsEditing = false
        self.present(image,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            camCell?.FoodImage.image = image //set image
        }else{
            //error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postListingButton(_ sender: Any) {
        
        let food = foodCell?.textInputField.text
        let location = locationCell?.textInputField.text
        let quantity = quantityCell?.quantityValue.text
        
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "h:mm a"
        
        let dateString = dateFormatter.string(from: currentDate)
        
        let listing = Listing(food:food ?? "food", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), time: dateString, location:location ?? "location", quantity: quantity ?? "Not Available", foodImage: camCell?.FoodImage.image ?? UIImage(named:"pizza")!)
        
        //listingModel.addListing(listing: listing)
        
        let numListings = listingModel.getNumberOfListings()
        print(numListings)
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
   
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        tableView.tableFooterView = UIView(frame: .zero)
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 2){
            return 200
        }else{
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
            self.foodCell = cell as? CustomTableViewCell
            self.foodCell?.cellLabel.text = "Food: "
            
            return cell
        }else if (indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "stepperCell", for: indexPath)
            self.quantityCell = cell as? StepperTableViewCell
            self.quantityCell?.quantityLabel.text = "Quantity:"
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cameraCell", for: indexPath)
            self.camCell = cell as? CameraCell
            return cell
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
}
