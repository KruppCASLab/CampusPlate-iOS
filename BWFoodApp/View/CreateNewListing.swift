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

class CreateNewListing: UIViewController,CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var postListing: UIButton!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    var mapView = MapViewController()
    
    let listingModel = ListingModel.getSharedInstance()
    
    var locationManager = CLLocationManager()
    
    public var listing:WSListing!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftView = UITextField(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
               
        let leftView2 = UITextField(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        
        let leftView3 = UITextField(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        
        itemTextField.layer.cornerRadius = 16
        itemTextField.layer.borderWidth = 2
        itemTextField.layer.borderColor = UIColor.systemOrange.cgColor
        itemTextField.leftView = leftView
        itemTextField.leftViewMode = .always
        itemTextField.contentVerticalAlignment = .center
        
        quantityTextField.layer.cornerRadius = 16
        quantityTextField.layer.borderWidth = 2
        quantityTextField.layer.borderColor = UIColor.systemOrange.cgColor
        quantityTextField.leftView = leftView2
        quantityTextField.leftViewMode = .always
        quantityTextField.contentVerticalAlignment = .center
        
        
        locationTextField.layer.cornerRadius = 16
        locationTextField.layer.borderWidth = 2
        locationTextField.layer.borderColor = UIColor.systemOrange.cgColor
        locationTextField.leftView = leftView3
        locationTextField.leftViewMode = .always
        locationTextField.contentVerticalAlignment = .center
        
        
        foodImage.layer.borderWidth = 2
        foodImage.layer.cornerRadius = 15
        foodImage.layer.borderColor = UIColor.systemOrange.cgColor
        self.locationManager.requestWhenInUseAuthorization()
        
        postListing.layer.cornerRadius = 20
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        itemTextField.delegate = self
        itemTextField.returnKeyType = .done
        
        quantityTextField.keyboardType = .numberPad
        quantityTextField.delegate = self
        quantityTextField.returnKeyType = .done
        
        locationTextField.delegate = self
        locationTextField.returnKeyType = .done
        
        locationManager.delegate = self

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        itemTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
        }
    }
    
    @IBAction func cancelListing(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        print("cancelled")
    }
    
    
//    @IBAction func TakePicture(_ sender: AnyObject) {
//        let image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerController.SourceType.camera
//        image.allowsEditing = false
//        self.present(image,animated: true)
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        {
//            camCell?.FoodImage.image = image //set image
//        }else{
//            //error message
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
    
    
    @IBAction func postListingButton(_ sender: Any) {
        
        postListing.isEnabled = false
        
        let food = (itemTextField.text) ?? ""
        let quantity = Int(quantityTextField.text ?? "0") ?? 0
        let subLocation = locationTextField.text
        
//        let date = Date(timeIntervalSince1970: 1415637900)
        
        let listing = WSListing(listingId: -1, userId: -1, title: food, lat: latitude, lng: longitude, creationTime: -1, quantity: quantity)

        listingModel.addListing(listing: listing) { (completed) in
            if (!completed) {
                let alert = UIAlertController(title: "Failed!", message: "Failed", preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }

            }
            else {
                DispatchQueue.main.async {
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
}

