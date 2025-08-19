//
//  ShowEligibleSchoolsViewController.swift
//  BWFoodApp
//
//  Created by Leighton Medved on 1/13/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class ShowEligibleSchoolsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
   
    let schoolImage = ["BW Logo"]
    var schoolName = ["Baldwin Wallace University"]
    var schoolLocation = ["Berea, OH"]
    
    var eligibleSchoolCell: EligibleSchoolCustomCell?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return schoolName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          let cell = tableView.dequeueReusableCell(withIdentifier: "eligibleSchoolCell", for: indexPath)
        
        self.eligibleSchoolCell = cell as? EligibleSchoolCustomCell
        
        self.eligibleSchoolCell?.eligibleSchoolLocation.text = schoolLocation[indexPath.row]
        
        self.eligibleSchoolCell?.eligibleSchoolTitle.text = schoolName[indexPath.row]
        
        return cell
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func dismissSchools(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
