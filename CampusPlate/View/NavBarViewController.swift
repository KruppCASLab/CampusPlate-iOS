//
//  NavBarViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 3/17/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import UIKit

class NavBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))

        // Do any additional setup after loading the view.
    }
    
    @objc func addTapped(){
        self.dismiss(animated: true, completion: nil)
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
