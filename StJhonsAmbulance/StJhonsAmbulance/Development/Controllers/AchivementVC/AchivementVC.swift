//
//  AchivementVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/03/2023.
//

import UIKit

enum EngagementType {
    
    case Engagement
    case Calender
}

class AchivementVC: ENTALDBaseViewController {

    var awardData : [VolunteerAwardModel]?
    var engagementData : [ScheduleModelThree]?
    var engagementType : EngagementType = .Engagement
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableHeaderView: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (engagementType == .Calender){
            self.engagementData = self.dataModel as? [ScheduleModelThree]
            lblName.isHidden = true
            lblDate.isHidden = true
            lblTitle.text = "Events"
            
        }else{
            self.awardData = self.dataModel as? [VolunteerAwardModel]
        }
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "AchivementTVC", bundle: nil), forCellReuseIdentifier: "AchivementTVC")
        tableView.register(UINib(nibName: "CalenderEventTVC", bundle: nil), forCellReuseIdentifier: "CalenderEventTVC")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            DispatchQueue.main.async {
                var height = self.tableView.contentSize.height
                if height < 80 {
                    self.tableViewHeightConstraint.constant = 80
                }else{
                    self.tableViewHeightConstraint.constant =  self.tableView.contentSize.height
                }
            }
        }
    }
    
    func decorateUI(){
        
        lblTitle.textColor = UIColor.themePrimaryColor
        lblTitle.font = UIFont.BoldFont(22)
        lblName.textColor = UIColor.themePrimary
        lblName.font = UIFont.BoldFont(14)
        lblDate.textColor = UIColor.themePrimary
        lblDate.font = UIFont.BoldFont(14)
        
        tableHeaderView.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        tableHeaderView.layer.borderWidth = 1.5
        
    }

    @IBAction func closeTapped(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    
    @IBAction func hourCalenderTapped(_ sender: Any) {
        let cellModel = self.engagementData
        callbackToController?(cellModel, self)
        
    }
    
}

extension AchivementVC : UITableViewDelegate,UITableViewDataSource {
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
        cell.lblName.text = cellModel?.msnfp_name
        if let date = cellModel?.msnfp_awarddate {
            
            let dateStr = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yy/MM/dd")
            cell.lblDate.text = dateStr
        }else{
            cell.lblDate.text = ""
        }
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
//            cell.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.backgroundColor = UIColor.viewLightColor
//            cell.seperaterView.backgroundColor = UIColor.gray
        }
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(engagementType == .Calender){
            return 100
        }
        return 30
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
    
}
