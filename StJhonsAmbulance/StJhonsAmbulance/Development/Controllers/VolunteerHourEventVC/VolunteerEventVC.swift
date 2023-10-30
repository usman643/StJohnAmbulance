//
//  VolunteerEventVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 22/06/2023.
//

import UIKit

class VolunteerEventVC: ENTALDBaseViewController {

    var eventData : [PendingShiftModelTwo]?
    var nonEventData : [PendingShiftModelTwo]?
    var eventFilterData : [PendingShiftModelTwo]?
    var nonEventFilterData : [PendingShiftModelTwo]?
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    
    @IBOutlet weak var pendingImgMainView1: UIView!
    @IBOutlet weak var pendingImgView: UIImageView!
    @IBOutlet weak var lblPendingValue: UILabel!
    @IBOutlet weak var lblPendingTitle: UILabel!
    
    @IBOutlet weak var yearImgMainView: UIView!
    @IBOutlet weak var yearImgView: UIImageView!
    @IBOutlet weak var lblYearValue: UILabel!
    @IBOutlet weak var lblYearTitle: UILabel!
    
    @IBOutlet weak var lifetimeImgMainView: UIView!
    @IBOutlet weak var lifetimeImgView: UIImageView!
    @IBOutlet weak var lblLifetimeValue: UILabel!
    @IBOutlet weak var lblLifetimeTitle: UILabel!
    
    @IBOutlet weak var btnCurveView: UIView!
    
    @IBOutlet weak var btnEvent: UIButton!
    @IBOutlet weak var btnNonEvent: UIButton!
    
    @IBOutlet weak var eventBtnBottomView: UIView!
    @IBOutlet weak var nonEventBtnBottomView: UIView!
    
    @IBOutlet weak var searchMainView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var textSearch: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var isEventLoadMoreShow = true
    var isNonEventLoadMoreShow = true
    
    @IBOutlet weak var loadMoreView: UIView!
    @IBOutlet weak var btnLoadMore: UIButton!

    @IBOutlet weak var btnSidemenu: UIButton!
    
    @IBOutlet weak var btnMessage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VolunterEventTVC", bundle: nil), forCellReuseIdentifier: "VolunterEventTVC")
        decorateUI()
        setContent()
        getVolunteerEvents()
        getVolunteerNonEvent()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func decorateUI(){
        searchMainView.isHidden = true
        self.selectNonEvent()
        lblScreenTitle.font = UIFont.HeaderBoldFont(18)
        lblScreenTitle.textColor = UIColor.headerGreen
        pendingImgMainView1.layer.cornerRadius = 15
        yearImgMainView.layer.cornerRadius = 15
        lifetimeImgMainView.layer.cornerRadius = 15
        
        lblPendingValue.font = UIFont.HeaderBoldFont(14)
        lblYearValue.font = UIFont.HeaderBoldFont(14)
        lblLifetimeValue.font = UIFont.HeaderBoldFont(14)
        
        lblPendingValue.textColor = UIColor.headerGreen
        lblYearValue.textColor = UIColor.headerGreen
        lblLifetimeValue.textColor = UIColor.headerGreen
        
        lblPendingTitle.font = UIFont.HeaderBoldFont(14)
        lblYearTitle.font = UIFont.HeaderBoldFont(14)
        lblLifetimeTitle.font = UIFont.HeaderBoldFont(14)

        btnCurveView.layer.cornerRadius = 20
    
        btnEvent.titleLabel?.font = UIFont.BoldFont(14)
        btnNonEvent.titleLabel?.font = UIFont.BoldFont(14)
        textSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        btnLoadMore.layer.borderColor = UIColor.themeColorSecondry.cgColor
        btnLoadMore.layer.borderWidth = 1.0
        btnLoadMore.setTitle("Load More", for: .normal)
        btnLoadMore.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        btnLoadMore.titleLabel?.font = UIFont.BoldFont(16)
        loadMoreView.isHidden = true
        let originalImage = UIImage(named: "messages-bubble-square-text")!
        let tintedImage = ProcessUtils.shared.tintImage(originalImage)
        btnMessage.setImage(tintedImage, for: .normal)
        let  sideMenuImage = UIImage(named: "sideMenu")!
        btnSidemenu.setImage(ProcessUtils.shared.tintImage(sideMenuImage), for: .normal)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text != ""){
            
            eventFilterData  =  eventData?.filter({
                if let name = $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                }
                return false
            })
            
            nonEventFilterData  =  nonEventData?.filter({
                if let name = $0.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle, name.lowercased().contains(textField.text?.lowercased() ?? "" ) {
                    return true
                 }
               return false
             })
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.eventFilterData = self.eventData
                self.nonEventFilterData = self.nonEventData
                self.tableView.reloadData()
            }
        }
    }
    
    func setContent(){
//        
        lblPendingValue.text = UserDefaults.standard.userInfo?.sjavms_totalpendinghrs?.getFormattedNumber()
        lblYearValue.text = UserDefaults.standard.userInfo?.sjavms_totalhourscompletedthisyear?.getFormattedNumber()
        lblLifetimeValue.text = UserDefaults.standard.userInfo?.msnfp_totalengagementhours?.getFormattedNumber()
    }
    
//    @IBAction func searchCloseTapped(_ sender: Any) {
//        textSearch.endEditing(true)
//        textSearch.text = ""
//        eventFilterData = eventData
//        nonEventFilterData = nonEventData
//        tableView.reloadData()
//    }
    

    func selectEvent(){
        
        btnEvent.isSelected = false
        btnNonEvent.isSelected = true
        eventBtnBottomView.isHidden = true
        nonEventBtnBottomView.isHidden = false
        btnEvent.setTitleColor(UIColor.textLightGrayColor, for: .normal)
        btnNonEvent.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        
      
//        btnEvent.titleLabel?.textColor = UIColor.textBlackColor
//        btnNonEvent.titleLabel?.textColor = UIColor.textLightGrayColor
        DispatchQueue.main.async {
            self.textSearch.text = ""
            self.tableView.reloadData()
        }
    }
    
    func selectNonEvent(){
        
        btnEvent.isSelected = true
        btnNonEvent.isSelected = false
        eventBtnBottomView.isHidden = false
        nonEventBtnBottomView.isHidden = true
        btnEvent.setTitleColor(UIColor.themeColorSecondry, for: .normal)
        btnNonEvent.setTitleColor(UIColor.textLightGrayColor, for: .normal)
        DispatchQueue.main.async {
            self.textSearch.text = ""
            self.tableView.reloadData()
            
//            let indexPath = IndexPath(row: 0, section: 0)
//            if let _ = self.tableView.cellForRow(at: indexPath) {
//                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//            }
        }
//        tableView.setContentOffset(CGPointZero, animated: true)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        present(menu!, animated: true)
    }
    
   
    @IBAction func eventTableShow(_ sender: Any) {
        selectNonEvent()
    }
    
    
    @IBAction func nonEventTableShow(_ sender: Any) {
        selectEvent()
    }
    
    @IBAction func messageTapped(_ sender: Any) {
        
        ENTALDControllers.shared.showGroupMessageVC(type: .ENTALDPUSH, from: self, callBack: nil)
    }
    
    @IBAction func eventLoadMoreTapped(_ sender: Any) {
     
        DispatchQueue.main.async {
            if (self.btnEvent.isSelected){
                self.isNonEventLoadMoreShow = false
            }else if (self.btnNonEvent.isSelected){
                self.isEventLoadMoreShow = false
            }
            self.loadMoreView.isHidden = true
            self.tableView.reloadData()
        }
    }
    

// MARK:  APIs
    
    
    func getVolunteerEvents(){
        guard let contactId = UserDefaults.standard.contactIdToken else {return}
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_schedulestatus,sjavms_hours,msnfp_participationscheduleid,sjavms_start,sjavms_end",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=sjavms_eventrequirements,msnfp_street2,msnfp_zippostalcode,msnfp_city,msnfp_engagementopportunitytitle,msnfp_location,msnfp_stateprovince,msnfp_street3,_sjavms_program_value,msnfp_street1)",
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(contactId)) and (sjavms_VolunteerEvent/sjavms_adhocevent eq true)",
            ParameterKeys.orderby : "msnfp_schedulestatus desc"
        ]
        
        self.getVolunteerEventsData(params: params)
    }
    
    fileprivate func getVolunteerEventsData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let apiData = response.value {
                    self.eventData = apiData
                    
                    self.eventData = self.eventData?.sorted {
                        $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
                    }
                    
                    self.eventFilterData = self.eventData
                }
//                    if (self.eventData?.count == 0 || self.eventData?.count == nil){
//                        self.showEmptyView(tableVw: self.tableView)
//                    }else{
//                        DispatchQueue.main.async {
//                            for subview in self.tableView.subviews {
//                                subview.removeFromSuperview()
//                            }
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }else{
//                    self.showEmptyView(tableVw: self.tableView)
//                }
            
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
    
    func getVolunteerNonEvent(){
        guard let contactId = UserDefaults.standard.contactIdToken else {return}
        let params : [String:Any] = [
            
        
            ParameterKeys.select :
                "msnfp_schedulestatus,sjavms_start,sjavms_end,_sjavms_volunteerevent_value,_msnfp_engagementopportunityscheduleid_value,sjavms_hours,msnfp_participationscheduleid,statecode,sjavms_checkedin",
            ParameterKeys.expand : "sjavms_VolunteerEvent($select=sjavms_eventrequirements,msnfp_street2,msnfp_zippostalcode,msnfp_city,msnfp_engagementopportunitytitle,msnfp_location,msnfp_stateprovince,msnfp_street3,_sjavms_program_value,msnfp_street1)",
            
            
            ParameterKeys.filter : "(statecode eq 0 and _sjavms_volunteer_value eq \(contactId)) and (sjavms_VolunteerEvent/sjavms_adhocevent ne true)",
            ParameterKeys.orderby : "_sjavms_volunteerevent_value asc,msnfp_schedulestatus desc"
        ]
        
        self.getVolunteerNonEventData(params: params)
    }
    
    fileprivate func getVolunteerNonEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerNonEvent(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let apiData = response.value {
                    self.nonEventData = apiData
                    
                    
                    self.nonEventData = self.nonEventData?.sorted {
                        $0.sjavms_start ?? "" < $1.sjavms_start ?? ""
                    }
                    self.nonEventFilterData = self.nonEventData
//                }
                    if (self.nonEventData?.count == 0 || self.nonEventData?.count == nil){
                        self.showEmptyView(tableVw: self.tableView)
                    }
                    else{
                        
                        DispatchQueue.main.async {
                            for subview in self.tableView.subviews {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else{
                    self.showEmptyView(tableVw: self.tableView)
                }
            
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
//                self.showEmptyView(tableVw: self.nonEventTableView)
                DispatchQueue.main.async {
                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
                }
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

}


extension VolunteerEventVC : UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (btnEvent.isSelected){
            if ((nonEventFilterData?.count ?? 0) > 3 && isNonEventLoadMoreShow){
                loadMoreView.isHidden = false
                return 3
            }
            return self.nonEventFilterData?.count ?? 0
           
        }else if (btnNonEvent.isSelected){
            
            if ((eventFilterData?.count ?? 0) > 3 && isEventLoadMoreShow){
                loadMoreView.isHidden = false
                return 3
            }
            return self.eventFilterData?.count ?? 0
           
        }
        
        
        return 0
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VolunterEventTVC", for: indexPath) as! VolunterEventTVC
        
        
        if (btnEvent.isSelected){
            let rowModel = self.nonEventFilterData?[indexPath.row]
            cell.setupContent(cellModel: rowModel)
            
        }else if (btnNonEvent.isSelected){
            let rowModel = self.eventFilterData?[indexPath.row]
            cell.setupContent(cellModel: rowModel)
            
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (btnNonEvent.isSelected){
            let rowModel = self.eventFilterData?[indexPath.row]
            
            ENTALDControllers.shared.showVolunteerHourDetailScreen(type: .ENTALDPUSH, from: self, dataObj : rowModel) { params, controller in
                if(params as? Int == 1){
                    self.getVolunteerEvents()
                }
            }
            
            
            
        }else if (btnEvent.isSelected){
            let rowModel = self.nonEventFilterData?[indexPath.row]
            
            ENTALDControllers.shared.showVolunteerHourDetailScreen(type: .ENTALDPUSH, from: self, dataObj : rowModel) { params, controller in
                if(params as? Int == 1){
                    self.getVolunteerNonEvent()
                }
            }
        }
    }
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let yOffset = scrollView.contentOffset.y
            if yOffset > 100 { // You can adjust this value according to when you want to show the custom view
                searchMainView.isHidden = false
            } else {
                searchMainView.isHidden = true
            }
        }
}
