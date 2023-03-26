//
//  EventMessagVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 25/03/2023.
//

import UIKit

class EventMessagVC: ENTALDBaseViewController {

    var messagesData : [MessageModel]?
    var eventData : CurrentEventsModel?
    var selectedStatus: String?
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSectionHeading: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet var lblTableHeadings: [UILabel]!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getMessages()
        decorateUI()
    }
    
    func registerCell(){
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib(nibName: "MessageTVC", bundle: nil), forCellReuseIdentifier: "MessageTVC")
    }

    func decorateUI(){
        
        lbltitle.font = UIFont.BoldFont(22)
        lblStatus.font = UIFont.BoldFont(14)
        lblSectionHeading.font = UIFont.BoldFont(14)
        lblStatus.textColor = UIColor.textWhiteColor
        lblSectionHeading.textColor = UIColor.themePrimaryWhite
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        btnMessage.layer.cornerRadius = btnMessage.frame.size.height/2
        btnStatus.layer.cornerRadius = 5
        for label in lblTableHeadings{
            label.textColor = UIColor.themePrimaryWhite
            label.font = UIFont.BoldFont(11)
        }
        
    }


    @IBAction func submitTapped(_ sender: Any) {
        
    }
    
    @IBAction func eventStatusUpdate(_ sender: Any) {
        self.showGroupsPicker()
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        ENTALDControllers.shared.showSendMessageScreen(type: .ENTALDPRESENT_POPOVER, from: self) { params, controller in
            
            if(params as? Int == 1){
                
                self.getMessages()
            }
            
        }
    }
    
    
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    //======================== API ==========================//
    
    func getMessages(){

        guard let groupId = ProcessUtils.shared.selectedUserGroup?.msnfp_groupId?.getGroupId() else {return}
            let params : [String:Any] = [

                ParameterKeys.select : "subject,statuscode,modifiedon,description,senton,activityid",
                ParameterKeys.filter : "(_regardingobjectid_value eq \(groupId))",
                ParameterKeys.orderby : "modifiedon desc"
                
            ]
            
            self.getMessagesData(params: params)
        
    }
    
    fileprivate func getMessagesData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestMessages(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let messagesData = response.value {
                    self.messagesData = messagesData
                    if (self.messagesData?.count == 0 || self.messagesData?.count == nil){
                        self.showEmptyView(tableVw: self.tableview)
                    }else{
                        
                        DispatchQueue.main.async {
                            for subview in self.tableview.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        
                        self.tableview.reloadData()
                    }
                    
                }else{
                    self.showEmptyView(tableVw: self.tableview)
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                self.showEmptyView(tableVw: self.tableview)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
            }
        }
    }
    
    func showGroupsPicker(){
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.eventStatus, dataObj: ProcessUtils.shared.eventStatusArr) { params, controller in
            self.selectedStatus  = params as? String
            var status = ProcessUtils.shared.eventStatusArr.filter({$0.value == params as? String}).first?.key
            self.updateEventStatus(statusValue : status ?? NSNotFound)
        }
    }
    
    func updateEventStatus(statusValue:Int){
        
            DispatchQueue.main.async {
                LoadingView.show()
            }
            var params:[String:Any] = [:]
            
            
                params["msnfp_engagementopportunitystatus"] = statusValue as Int
                
        ENTALDLibraryAPI.shared.updateEventStatus(eventid: self.eventData?.msnfp_engagementopportunityid ?? "", params: params){ result in
                DispatchQueue.main.async {
                    LoadingView.hide()
                }
                switch result{
                case .success(value: _):
                    break
                case .error(let error, let errorResponse):
                    if error == .patchSuccess {
                        ENTALDAlertView.shared.showContactAlertWithTitle(title: "Event Status Update Successfully", message: "", actionTitle: .KOK, completion: { status in })
                        self.btnStatus.setTitle(self.selectedStatus, for: .normal)
                    }else{
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
    
    
    
    
    
    
}

extension EventMessagVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "MessageTVC", for: indexPath) as! MessageTVC
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
           
        }else{
            cell.backgroundColor = UIColor.viewLightColor
           
        }
        
        
        cell.lblName.text = messagesData?[indexPath.row].subject
        cell.lblDate.text = DateFormatManager.shared.formatDateStrToStr(date: messagesData?[indexPath.row].modifiedon ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "dd/MM/yyyy")
        cell.lblMessage.text = messagesData?[indexPath.row].description
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ENTALDControllers.shared.showMessageDetailScreen(type: .ENTALDPRESENT_POPOVER, from: self, dataObj: messagesData?[indexPath.row], callBack: nil)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
