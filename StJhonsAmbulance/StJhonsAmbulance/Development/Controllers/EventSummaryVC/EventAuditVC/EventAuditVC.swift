//
//  EventAuditVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventAuditVC:ENTALDBaseViewController {
    
    var eventData : CurrentEventsModel?
    var auditHistory : [AuditModel]?
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblSectionHeading: UILabel!
    @IBOutlet var lblTableHeadings: [UILabel]!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
    }
    
    func registerCell(){
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib(nibName: "EventAuditTVC", bundle: nil), forCellReuseIdentifier: "EventAuditTVC")
    }

    func decorateUI(){
        
        lbltitle.font = UIFont.BoldFont(22)
        lblSectionHeading.font = UIFont.BoldFont(14)
        lblSectionHeading.textColor = UIColor.themePrimaryWhite

        for label in lblTableHeadings{
            label.textColor = UIColor.themePrimaryWhite
            label.font = UIFont.BoldFont(11)
        }
        
    }
    
    func setupData(){
        
        
    }


    @IBAction func submitTapped(_ sender: Any) {
        
    }
    
    @IBAction func StatusTapped(_ sender: Any) {
        
    }
    
    fileprivate func getAuditHistory(){
        guard let eventId = self.eventData?.msnfp_engagementopportunityid else {return}
        let params : [String:Any] = [
            
            ParameterKeys.filter : "_objectid_value eq \(eventId)",
            
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.getAuditHistory(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let apiData = response.value {
                    self.auditHistory = apiData
                    DispatchQueue.main.async {
                        self.setupData()
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

extension EventAuditVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.auditHistory?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventAuditTVC", for: indexPath) as! EventAuditTVC
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
        }else{
            cell.backgroundColor = UIColor.viewLightColor
        }
        
        let rowModel = self.auditHistory?[indexPath.row]
        cell.setContent(cellModel: rowModel)
        
        
        return cell
    }
    
    
    
}
