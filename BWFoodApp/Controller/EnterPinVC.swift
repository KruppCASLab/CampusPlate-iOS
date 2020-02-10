//
//  EnterPinVC.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/5/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

protocol EnterPinDelegate {
    func resetRegisterButton()
}

class EnterPinVC: UIViewController {
    
    public var delegate: EnterPinDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reEnterInfoButton(_ sender: Any) {
        
        self.delegate?.resetRegisterButton()
        
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
