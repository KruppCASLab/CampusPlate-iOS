//
//  createNewListing.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/21/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class createNewListing: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var foodTextInput: UITextField!
    @IBOutlet weak var locationTextInput: UITextField!
    @IBOutlet weak var timeTextInput: UITextField!
    
    private var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodTextInput.delegate = self
        foodTextInput.returnKeyType = .done
        locationTextInput.delegate = self
        locationTextInput.returnKeyType = .done
        timeTextInput.delegate = self
        timeTextInput.returnKeyType = .done
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        timeTextInput.addGestureRecognizer(tapGesture)
    
    }
    
    @objc func timeChanged(datePicker : UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH/MM"
        timeTextInput.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
    
    }
    
    @objc func showDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        DispatchQueue.main.async {
            self.timeTextInput.inputView = self.datePicker
            self.timeTextInput.setNeedsDisplay()
            self.view.setNeedsDisplay() 
            //self.datePicker?.addTarget(self, action: #selector(ViewController.timeChanged(datePicker:)), for: .valueChanged)
        }
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        foodTextInput.resignFirstResponder()
        locationTextInput.resignFirstResponder()
        timeTextInput.resignFirstResponder()
        return true
    }
    
    
    @IBAction func createListing(_ sender: UIButton) {
        let alert = UIAlertController(title: "Create Listing", message: "Your Listing Is Now Public!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.foodTextInput.text = ""
            self.locationTextInput.text = ""
            self.timeTextInput.text = ""
            
        }))
        
       present(alert, animated: true, completion: nil)
    }
    
   
    
    
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    
    }
    

}
