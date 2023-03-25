//
//  EventScheduleVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventScheduleVC: ENTALDBaseViewController {

    var eventId :String?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblSectionTitle: [UILabel]!
    @IBOutlet var lblTextFieldTitles: [UILabel]!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnStatusView: UIView!
    @IBOutlet var allTxtField: [UITextField]!
    @IBOutlet var lblTableHeadings: [UILabel]!
    @IBOutlet var lblAge: [UILabel]!
    @IBOutlet weak var lblMultidayEvent: UILabel!
    @IBOutlet weak var btnMultiday: UIButton!
    @IBOutlet weak var btnAgeOne: UIButton!
    @IBOutlet weak var btnAgeTwo: UIButton!
    @IBOutlet weak var btnAgeThree: UIButton!
    @IBOutlet weak var btnAgeFour: UIButton!
    
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
      
    }
    
    func registerCell(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "EventScheduleTVC", bundle: nil), forCellReuseIdentifier: "EventScheduleTVC")
    }
    
    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        btnStatusView.layer.cornerRadius = 5
        btnStatus.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnStatus.titleLabel?.font = UIFont.RegularFont(14)
        btnMultiday.layer.cornerRadius = 3
        lblMultidayEvent.font = UIFont.RegularFont(12)
        lblMultidayEvent.textColor = UIColor.themePrimaryWhite
        for label in lblAge{
            label.font = UIFont.RegularFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblSectionTitle{
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }
        for label in lblTableHeadings{
            label.font = UIFont.BoldFont(10)
            label.textColor = UIColor.themePrimaryWhite
        }
        for label in lblTextFieldTitles{
            label.font = UIFont.BoldFont(13)
            label.textColor = UIColor.themePrimaryWhite
        }

        for txtField in allTxtField{
            txtField.font = UIFont.RegularFont(13)
            txtField.textColor = UIColor.themePrimaryWhite
            txtField.layer.borderWidth = 1
            txtField.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        }
        
        
        
        
    }
    
    
    @IBAction func age1Tapped(_ sender: Any) {
    }

    @IBAction func age2Tapped(_ sender: Any) {
    }
    
    @IBAction func age3Tapped(_ sender: Any) {
    }
    
    @IBAction func age4Tapped(_ sender: Any) {
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
    }
    
}

extension EventScheduleVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventScheduleTVC", for: indexPath) as! EventScheduleTVC
        
        return cell
    }
}
