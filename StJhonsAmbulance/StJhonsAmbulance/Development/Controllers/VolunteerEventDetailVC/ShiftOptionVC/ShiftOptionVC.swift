//
//  ShiftOptionVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 19/03/2023.
//

import UIKit

class ShiftOptionVC: ENTALDBaseViewController {
    
    var eventOptions : [VolunteerEventClickOptionModel]?
    var eventId : String?
    
    var isShiftFilterApplied = false
    var isStartFilterApplied = false
    var isEndFilterApplied = false
    var isHourFilterApplied = false
    var isNeedFilterApplied = false
    
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet var headingAllLabel: [UILabel]!
    @IBOutlet weak var tableHeadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnBook: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.decorateUI()
        registerCell()
        self.getEventOptions()
    }
    
    func registerCell(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ShiftOptionTVC", bundle: nil), forCellReuseIdentifier: "ShiftOptionTVC")
        
    }

    func decorateUI(){
        lblTitle.font = UIFont.BoldFont(22)
        lblTitle.textColor = UIColor.themePrimaryColor
        for label in headingAllLabel{
            label.font = UIFont.RegularFont(11)
            label.textColor = UIColor.themePrimary
        }
        tableHeadingView.layer.borderWidth = 1.5
        tableHeadingView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        
        btnCancel.layer.cornerRadius = btnCancel.frame.size.height/2
        btnCancel.backgroundColor = UIColor.themePrimaryColor
        btnCancel.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnCancel.titleLabel?.textColor = UIColor.textWhiteColor
        btnCancel.titleLabel?.font = UIFont.BoldFont(16)
        btnBook.layer.cornerRadius = btnBook.frame.size.height/2
        btnBook.backgroundColor = UIColor.themePrimaryColor
        btnBook.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnBook.titleLabel?.textColor = UIColor.textWhiteColor
        btnBook.titleLabel?.font = UIFont.BoldFont(16)
    }
    
    // ================== Filters =================
   
    @IBAction func filterTapped(_ sender: Any) {
        
        if !isShiftFilterApplied{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_engagementopportunityschedule ?? "" < $1.msnfp_engagementopportunityschedule ?? ""
            }
            isShiftFilterApplied = true
        }else{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_engagementopportunityschedule ?? "" > $1.msnfp_engagementopportunityschedule ?? ""
            }
            isShiftFilterApplied = false
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isStartFilterApplied = false
        isEndFilterApplied = false
        isHourFilterApplied = false
        isNeedFilterApplied = false
    }
    @IBAction func shiftFilterTapped(_ sender: Any) {
        if !isShiftFilterApplied{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_engagementopportunityschedule ?? "" < $1.msnfp_engagementopportunityschedule ?? ""
            }
            isShiftFilterApplied = true
        }else{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_engagementopportunityschedule ?? "" > $1.msnfp_engagementopportunityschedule ?? ""
            }
            isShiftFilterApplied = false
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isStartFilterApplied = false
        isEndFilterApplied = false
        isHourFilterApplied = false
        isNeedFilterApplied = false
        
    }
    @IBAction func startFilterTapped(_ sender: Any) {
        if !isStartFilterApplied{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_effectivefrom ?? "" < $1.msnfp_effectivefrom ?? ""
            }
            isStartFilterApplied = true
        }else{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_effectivefrom ?? "" > $1.msnfp_effectivefrom ?? ""
            }
            isStartFilterApplied = false
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isEndFilterApplied = false
        isHourFilterApplied = false
        isNeedFilterApplied = false
        
    }
    @IBAction func endFilterTapped(_ sender: Any) {
        if !isEndFilterApplied{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_effectiveto ?? "" < $1.msnfp_effectiveto ?? ""
            }
            isEndFilterApplied = true
        }else{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_effectiveto ?? "" > $1.msnfp_effectiveto ?? ""
            }
            isEndFilterApplied = false
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isStartFilterApplied = false
        isHourFilterApplied = false
        isNeedFilterApplied = false
        
    }
    @IBAction func hoursFilterTapped(_ sender: Any) {
        if !isHourFilterApplied{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_hours ?? Float() < $1.msnfp_hours ?? Float()
            }
            isHourFilterApplied = true
        }else{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_hours ?? Float() > $1.msnfp_hours ?? Float()
            }
            isHourFilterApplied = false
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isStartFilterApplied = false
        isEndFilterApplied = false
        isNeedFilterApplied = false
        isHourFilterApplied = false
        
    }
    
    @IBAction func neededFilterTapped(_ sender: Any) {
        if !isNeedFilterApplied{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_maximum ?? NSNotFound < $1.msnfp_maximum ?? NSNotFound
            }
            isNeedFilterApplied = true
        }else{
            self.eventOptions = self.eventOptions?.sorted {
                $0.msnfp_maximum ?? NSNotFound > $1.msnfp_maximum ?? NSNotFound
            }
            isNeedFilterApplied = false
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        isShiftFilterApplied = false
        isStartFilterApplied = false
        isEndFilterApplied = false
 
        
    }
    
    @IBAction func bokkEventTapped(_ sender: Any) {
        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
    }
    
    @IBAction func closeEventTapped(_ sender: Any) {
        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Alert", message: "Coming Soon", actionTitle: .KOK, completion: {status in })
        
    }
    
    
   
    

    
    
    
    
    
    
    
    func getEventOptions() {
        
        let params : [String:Any] = [
            ParameterKeys.select : "statecode,msnfp_effectivefrom,msnfp_effectiveto,msnfp_engagementopportunityscheduleid,msnfp_hours,msnfp_maximum,msnfp_engagementopportunityschedule",
            ParameterKeys.filter : "(_msnfp_engagementopportunity_value eq \(self.eventId ?? ""))"
        ]
        
        self.getEventOptionData(params: params)
        
    }
    
    
    fileprivate func getEventOptionData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerEventClickOption(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let option = response.value {
                    self.eventOptions = option
                    
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }

                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
}


extension ShiftOptionVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventOptions?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftOptionTVC", for: indexPath) as! ShiftOptionTVC
        
        cell.setContent(cellModel: self.eventOptions?[indexPath.row])
        
        return cell
    }
    
}
