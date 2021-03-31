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

protocol CreateNewListingDelegate {
    func didComplete()
}

class CreateNewListing:
    UIViewController,CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    public var delegate:CreateNewListingDelegate?
    public var mapViewDelegate: MapViewController?
    
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    //    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    @IBOutlet weak var weightField: UITextField!
    
    let impact = UIImpactFeedbackGenerator()
    
    
    @IBOutlet weak var expirationTimeField: UITextField!
    
    let listingModel = ListingModel.getSharedInstance()
    let foodStopModel = FoodStopModel.getSharedInstance()
    
    var locationManager = CLLocationManager()
    
    public var listing:Listing!
    
    var selectedFoodStop: FoodStop?
    
    let foodStopPicker = UIPickerView()
    
    var foodStopPickerData = [FoodStop]()
    
    @IBOutlet weak var createButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodStopPicker.delegate = self
        //activityIndicator.isHidden = true
        
        createButton.isEnabled = false
        
        foodStopModel.loadManagedFoodStops { [self] (completed) in
            foodStopPickerData = foodStopModel.managedFoodStops
            
            self.selectedFoodStop = foodStopPickerData[0]
            DispatchQueue.main.async {
                locationTextField.text = foodStopPickerData[0].name
            }
        }
        
        let leftView = UITextField(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        
        let leftView2 = UITextField(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        
        let leftView3 = UITextField(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        
        foodImage.layer.borderColor = UIColor.init(named: "CampusPlateGreen")?.cgColor
        self.locationManager.requestWhenInUseAuthorization()
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        itemTextField.delegate = self
        itemTextField.returnKeyType = .done
        
        quantityTextField.keyboardType = .numberPad
        quantityTextField.delegate = self
        quantityTextField.returnKeyType = .done
        
        locationTextField.inputView = foodStopPicker
        locationTextField.delegate = self
        locationTextField.returnKeyType = .done
        
        locationManager.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (itemTextField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty {
            createButton.isEnabled = false
        } else {
            createButton.isEnabled = true
        }
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodStopPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foodStopPickerData[row].name
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationTextField.text = foodStopPickerData[row].name
        selectedFoodStop = foodStopPickerData[row]
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        
        navigationController?.navigationBar.barTintColor = UIColor.init(named: "CampusPlateGreenNew")
        
        //        navigationController?.navigationBar.backgroundColor = UIColor.init(named: "CampusPlateGreenNew")
        //        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    
    
    @IBAction func takePicture(_ sender: UIButton) {
        
        impact.impactOccurred()
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.camera
        image.allowsEditing = true
        self.present(image,animated: true)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            foodImage.image = image //set image
            
        }else{
            //error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createListingButton(_ sender: UIButton) {
        //createListingButton.isEnabled = false
        //activityIndicator.isHidden = false
        
        //activityIndicator.startAnimating()
        
        //createListingButton.alpha = 0.5
        
        var formCompleted = true
        
        createButton.isEnabled = false
        
        let foodName = itemTextField.text
        let description = descriptionTextView.text
        
        var quantity = 0
        var expiratonTime = 0
        var weight = 0
        
        if let quantityText = quantityTextField.text {
            if let quantityInt = Int(quantityText) {
                quantity = quantityInt
            }
            else {
                formCompleted = false
            }
        }
        
        if let expirationText = expirationTimeField.text {
            if let expirationInt = Int(expirationText) {
                expiratonTime = expirationInt
            }
            else {
                formCompleted = false
            }
        }
        
        if let weightText = weightField.text {
            if let weightInt = Int(weightText) {
                weight = weightInt
            }
            else {
                formCompleted = false
            }
        }
        
        if foodName?.count == 0 {
            formCompleted = false
        }
        
        guard formCompleted else {
            let alert = UIAlertController(title: "Invalid Listing", message: "Please check the values in the form", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                if foodName?.count != 0 {
                    self.createButton.isEnabled = true
                }
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        let image = foodImage.image
        
        let unixTimeStampExpiration = expiratonTime * 86400 + Int(NSDate().timeIntervalSince1970)
        
        var listing:Listing
        if let image = image {
            let imageData = image.jpegData(compressionQuality: 0.05)!
            let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            
            listing = Listing(foodStopId: selectedFoodStop!.foodStopId,title: foodName!, description: description!, quantity: quantity, image: imageBase64, expirationTime: Int(unixTimeStampExpiration), weightOunces: weight)
        }
        else {
            listing = Listing(foodStopId: selectedFoodStop!.foodStopId,title: foodName!, description: description!, quantity: quantity, expirationTime: Int(unixTimeStampExpiration), weightOunces: weight)
        }
 
        listingModel.addListing(listing: listing) { (completed) in
            if (!completed) {
                let alert = UIAlertController(title: "Listing could not be created.", message: "Please try again later.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (completed) in
                    self.createButton.isEnabled = true
                }))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.didComplete()
                }
            }
            
        }
        
    }
}


