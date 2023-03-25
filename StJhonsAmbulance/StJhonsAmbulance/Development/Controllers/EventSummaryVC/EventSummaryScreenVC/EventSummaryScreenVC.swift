//
//  EventSummaryScreenVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/03/2023.
//

import UIKit

class EventSummaryScreenVC: ENTALDBaseViewController {

    var eventId : String?
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblShortDesc: UILabel!
    @IBOutlet weak var btnSelectStatus: UIButton!
    @IBOutlet weak var btnSelectProgram: UIButton!
    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var txtEventDesc: UITextView!
    @IBOutlet weak var btnAdhoc: UIButton!
    @IBOutlet weak var lblAdhoc: UILabel!
    @IBOutlet weak var tableHeadingView: UIView!
    @IBOutlet weak var eventDescTxtView: UIView!
    @IBOutlet weak var eventNameTxtView: UIView!
    @IBOutlet weak var selectStatusView: UIView!
    @IBOutlet weak var selectProgramView: UIView!
    @IBOutlet var lblTitles: [UILabel]!
    @IBOutlet var lblTableHeading: [UILabel]!
    @IBOutlet var lblShiftSchedule: [UILabel]!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EventSummaryScreenTVC", bundle: nil), forCellReuseIdentifier: "EventSummaryScreenTVC")
        decorateUI()
    }

    func decorateUI(){
        
        lblTitle.font = UIFont.BoldFont(22)
        lblStatus.font = UIFont.BoldFont(14)
        lblStatus.textColor = UIColor.themePrimaryColor
        lblEventName.font = UIFont.BoldFont(14)
        lblEventName.textColor = UIColor.themePrimaryColor
        lblProgram.font = UIFont.BoldFont(14)
        lblProgram.textColor = UIColor.themePrimaryColor
        lblShortDesc.font = UIFont.BoldFont(14)
        lblShortDesc.textColor = UIColor.themePrimaryColor
        lblAdhoc.font = UIFont.RegularFont(12)
        lblAdhoc.textColor = UIColor.themePrimaryColor
        selectStatusView.layer.cornerRadius = 5
        selectProgramView.layer.cornerRadius = 5
        eventNameTxtView.layer.borderWidth = 1
        eventNameTxtView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        eventDescTxtView.layer.borderWidth = 1
        eventDescTxtView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        tableHeadingView.layer.borderWidth = 1
        tableHeadingView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        txtEventName.font = UIFont.RegularFont(12)
        txtEventName.textColor = UIColor.themeBlackText
        txtEventDesc.font = UIFont.RegularFont(12)
        txtEventDesc.textColor = UIColor.themeBlackText
        
        for label in lblTitles{
            label.font = UIFont.BoldFont(14)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblShiftSchedule{
            label.font = UIFont.BoldFont(13)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        for label in lblTableHeading{
            label.font = UIFont.BoldFont(12)
            label.textColor = UIColor.themePrimaryWhite
        }
        
        
        
    }
    
    
    @IBAction func adhocEventTapped(_ sender: Any) {
        
        
    }
    @IBAction func submitTapped(_ sender: Any) {
        
        
    }
    
    @IBAction func volunteerFilter(_ sender: Any) {
    }
    
    @IBAction func evnetFilter(_ sender: Any) {
    }
    
    @IBAction func startFilter(_ sender: Any) {
    }
    
    @IBAction func hourFilter(_ sender: Any) {
    }
    
    
    
    
    
    
}


extension EventSummaryScreenVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventSummaryScreenTVC", for: indexPath) as! EventSummaryScreenTVC
        
        return cell
    }
    
    
    
    
    
    
}
