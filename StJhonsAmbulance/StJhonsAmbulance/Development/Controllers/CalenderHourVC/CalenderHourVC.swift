//
//  CalenderHourVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 21/05/2023.
//

import UIKit

class CalenderHourVC: ENTALDBaseViewController {
    
    var hoursArr = ["12:00 AM","01:00 AM","02:00 AM","03:00 AM","04:00 AM","05:00 AM","06:00 AM","07:00 AM","08:00 AM","09:00 AM","10:00 AM","11:00 AM","12:00 PM","01:00 PM","02:00 PM","03:00 PM","04:00 PM","05:00 PM","06:00 PM","07:00 PM","08:00 PM","09:00 PM","10:00 PM","11:00 PM"]
    var engagementData : [ScheduleModelThree]?
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.engagementData = self.dataModel as? [ScheduleModelThree]
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "CalenderHourTVC", bundle: nil), forCellReuseIdentifier: "CalenderHourTVC")
    }
    
    @IBAction func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CalenderHourVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderHourTVC", for: indexPath) as! CalenderHourTVC
        cell.lblHour.text = hoursArr[indexPath.row]
        for i in (0..<(self.engagementData?.count ?? 0)) {
            if let date = self.engagementData?[i].sjavms_start {
                let startDate = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh a")
                let endDate = DateFormatManager.shared.formatDateStrToStr(date: self.engagementData?[i].sjavms_end ?? "", oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "hh a")
                let calenderHour = DateFormatManager.shared.formatDateStrToStr(date: hoursArr[indexPath.row], oldFormat:"hh:mm a", newFormat: "hh a")
                
                if (startDate == calenderHour){
                    cell.hourHighLightView.backgroundColor = UIColor.darkBlueColor.withAlphaComponent(0.7)
                }
                
                if (endDate == calenderHour){
                    cell.hourHighLightView.backgroundColor = UIColor.redPinkColor.withAlphaComponent(0.7)
                }
            }
            
        }
        return cell
    }
    
    
    
    
}
