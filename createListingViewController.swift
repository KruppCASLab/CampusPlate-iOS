//
//  createListingViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/21/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class createListingViewController: UIViewController {
    
    var line = UIBezierPath()
    
    func graph(){
        line.move(to: .init(x: 0, y: bounds.height / 2))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
