//
//  UserEngagementsVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 02/05/2023.
//

import UIKit

class UserEngagementsVC: ENTALDBaseViewController {
    
    var scheduleEngagementData : [ScheduleEngagementModel]?
    
    let conId = UserDefaults.standard.contactIdToken ?? ""
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserEngagementsTVC", bundle: nil), forCellReuseIdentifier: "UserEngagementsTVC")
        decorateUI()
        getEngagement()
    }

    func decorateUI(){
        lblTitle.textColor = UIColor.themePrimaryWhite
        lblTitle.font = UIFont.BoldFont(20)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getEngagement(){
        
        let params : [String:Any] = [
            "id" : self.conId
        ]

        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestScheduleEngagmentData(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                debugPrint(response)
                if (response.count > 0){
                    self.scheduleEngagementData = response
                    if (self.scheduleEngagementData?.count == 0 || self.scheduleEngagementData?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                    }else{
                        
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                            self.tableView.reloadData()
                        }
                    }
                }else{
                    self.showEmptyView(tableVw: self.tableView)
                }
//
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.tableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
//            let view = EmptyView.instanceFromNib()
//            view.frame = tableVw.frame
//            tableVw.addSubview(view)
        }
    }
    


}

extension UserEngagementsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scheduleEngagementData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserEngagementsTVC", for: indexPath) as! UserEngagementsTVC
        let rowModel = self.scheduleEngagementData?[indexPath.row]
        cell.setContent(cellModel: rowModel)
        cell.btnDetail.tag = indexPath.row
        cell.btnDetail.addTarget(self, action: #selector(self.voulenteerDetail(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let rowModel = scheduleEngagementData?[indexPath.row]
//        
//        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "engagement" , callBack: nil)
    }
    
    @objc func voulenteerDetail(_ sender:UIButton){
        let tag = sender.tag
        let rowModel = scheduleEngagementData?[tag]
        
        ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: rowModel, eventType : "engagement") { params, controller in
            self.getEngagement()
        }
    }
    
}
