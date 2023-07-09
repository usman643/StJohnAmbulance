//
//  AwardsVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 10/07/2023.
//

import UIKit

class AwardsVC: ENTALDBaseViewController {
    
    var awardData : [VolunteerAwardModel]?
    var engagementData : [ScheduleModelThree]?
    var engagementType : EngagementType = .Engagement
    let contactId = UserDefaults.standard.contactIdToken ?? ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (engagementType == .Calender){
            self.engagementData = self.dataModel as? [ScheduleModelThree]


        }else{
            self.awardData = self.dataModel as? [VolunteerAwardModel]
            self.getVolunteerAward()
        }
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "AchivementTVC", bundle: nil), forCellReuseIdentifier: "AchivementTVC")
        tableView.register(UINib(nibName: "CalenderEventTVC", bundle: nil), forCellReuseIdentifier: "CalenderEventTVC")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func decorateUI(){
        
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    
    @IBAction func hourCalenderTapped(_ sender: Any) {
        let cellModel = self.engagementData
        callbackToController?(cellModel, self)
        
    }
    
}

extension AwardsVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (engagementType == .Calender){
            return   self.engagementData?.count ?? 0
        }else{
            return   self.awardData?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(engagementType == .Calender){
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderEventTVC", for: indexPath) as! CalenderEventTVC
            
            let cellModel = self.engagementData?[indexPath.row]
            
            cell.lblEventName.text = cellModel?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
            //            cell.lblName.text = cellModel?.msnfp_name
            if let date = cellModel?.sjavms_start {
                
                let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
                var endDate = ""
                if let endDateStr = cellModel?.sjavms_end {
                    endDate =   DateFormatManager.shared.formatDateStrToStr(date: endDateStr, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
                }
                
                cell.lblDate.text = "\(dateStr) - \(endDate)"
            }else{
                cell.lblDate.text = ""
            }
            cell.btnDetail.tag = indexPath.row
            cell.btnDetail.addTarget(self, action: #selector(showCalenderEventDetail(_ :)), for: .touchUpInside)
            
            return cell
            
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AchivementTVC", for: indexPath) as! AchivementTVC
        
        let cellModel = self.awardData?[indexPath.row]
        cell.lblName.text = "Name: \(cellModel?.name ?? "")"
        if let date = cellModel?.msnfp_awarddate {
            
            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
            cell.lblDate.text = "Date: \(dateStr)"
        }else{
            cell.lblDate.text = "Date: Not Found"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(engagementType == .Calender){
            return 100
        }
        return UITableView.automaticDimension
    }
    
    @objc func showCalenderEventDetail(_ sender:UIButton){
        let index = sender.tag
        let cellModel = self.engagementData?[index]
        callbackToController?(cellModel, self)
    }
    
    @objc func showCalenderHour(_ sender:UIButton){
        let index = sender.tag
        let cellModel = self.engagementData
        callbackToController?(cellModel, self)
    }
    
    func getVolunteerAward(){
        
        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "_msnfp_awardid_value,msnfp_awarddate,msnfp_awardversionid,msnfp_name",
            //            ParameterKeys.expand : "msnfp_groupId",
            ParameterKeys.filter : "(msnfp_status eq 844060003 and _msnfp_primarycontactid_value eq \(contactId))",
            ParameterKeys.orderby : "_msnfp_awardid_value asc"
        ]
        
        self.getVolunteerAwardData(params: params)
    }
    
    fileprivate func getVolunteerAwardData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerAward(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                DispatchQueue.main.async {
                    if let award = response.value {
                        self.awardData = award
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        //                        self.lblAward.text = "\(award.count)"
                        //                        self.awardNumView.isHidden = false
                        //                        self.lblAward.isHidden = false
                        
                    }
                    //                    else{
                    //                        self.awardNumView.isHidden = true
                    //                        self.lblAward.isHidden = true
                    //                    }
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

