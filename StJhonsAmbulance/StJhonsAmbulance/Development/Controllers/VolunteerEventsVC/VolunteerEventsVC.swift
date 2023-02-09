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
    
    @IBOutlet weak var availableHeaderView: UIView!
    @IBOutlet weak var scheduleHeaderView: UIView!
    @IBOutlet weak var pastHeaderView: UIView!
    
    @IBOutlet weak var availableTable: UITableView!
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var pastTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        decorateUI()
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
        
        availableHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        availableHeaderView.layer.borderWidth = 1
        
        scheduleHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        scheduleHeaderView.layer.borderWidth = 1
        
        pastHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        pastHeaderView.layer.borderWidth = 1
        

    }
    
    func registerCells(){
        
        availableTable.delegate = self
        availableTable.dataSource = self
        availableTable.register(UINib(nibName: "VolunteerEventTVC", bundle: nil), forCellReuseIdentifier: "VolunteerEventTVC")
        
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
        scheduleTable.register(UINib(nibName: "VolunteerEventTVC", bundle: nil), forCellReuseIdentifier: "VolunteerEventTVC")
        
        pastTable.delegate = self
        pastTable.dataSource = self
        pastTable.register(UINib(nibName: "VolunteerEventTVC", bundle: nil), forCellReuseIdentifier: "VolunteerEventTVC")

    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

extension VolunteerEventsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteerEventTVC", for: indexPath) as! VolunteerEventTVC
        
        return cell
    }
    
    
}
