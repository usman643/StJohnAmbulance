//
//  VolunteerEventsVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/02/2023.
//

import UIKit

class VolunteerEventsVC: UIViewController {

    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet var allHeadingLabels: [UILabel]!
    @IBOutlet var allLabels: [UILabel]!
    
    
    @IBOutlet weak var availableTable: UITableView!
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var pastTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    func decorateUI(){
        
        for lbltext in allLabels{
            lbltext.font = UIFont.BoldFont(12)
            lbltext.textColor = UIColor.themePrimaryColor
        }
        for lbltext in allHeadingLabels{
            lbltext.font = UIFont.BoldFont(18)
            lbltext.textColor = UIColor.themePrimaryColor
        }
        
    }

    @IBAction func backTapped(_ sender: Any) {
    }
    
    @IBAction func homeTapped(_ sender: Any) {
    }
    
    @IBAction func availableFilterTapped(_ sender: Any) {
        
    }
    
    @IBAction func scheduledFilterTapped(_ sender: Any) {
        
    }
    
    @IBAction func pastFilterTapped(_ sender: Any) {
    }
    
    
}

//extension VolunteerEventsVC : UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
//}
