//
//  LandingVC.swift
//  SJA
//
//  Created by ENT20121341 on 20/01/2023.
//

import UIKit

class LandingVC: ENTALDBaseViewController {

    
    @IBOutlet weak var headerLogoView: UIView!
    @IBOutlet weak var headerLogoImgView: UIImageView!
    
    @IBOutlet weak var MainVw: UIView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    let conId = UserDefaults.standard.contactIdToken ?? ""
    
    var selectedUserGroup : LandingGroupsModel?
    var genderData : [LanguageModel] = []
//    var prefferedLanguageData : [LanguageModel] = []
    var prefferedPronounData : [LanguageModel] = []
    var prefferedMethodContactData : [LanguageModel] = []
    var languageData : [LanguageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
        
        self.getGroups()
        self.getGender()
        self.getPrefferedNoun()
        self.getPrefferedMethodContact()
        self.getPrefferedLanguage()
    }

    func decorateUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.themeSecondry
        headerLogoView.layer.cornerRadius =  headerLogoView.frame.size.height/2
        headerLogoView.backgroundColor = UIColor.themePrimary
        MainVw.layer.cornerRadius = 40
        MainVw.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        btn1.layer.cornerRadius = 4
        btn1.backgroundColor = UIColor.themeSecondry
        btn1.setTitleColor(UIColor.white, for: .normal)
        btn2.layer.cornerRadius = 4
        btn2.backgroundColor = UIColor.themeSecondry
        btn2.setTitleColor(UIColor.white, for: .normal)
        
        btn1.titleLabel?.font = UIFont.BoldFont(14)
        btn2.titleLabel?.font = UIFont.BoldFont(14)
        lblTitle.font = UIFont.BoldFont(24)
        lblDesc.font = UIFont.BoldFont(16)
        
        
        nextBtn.themeColorButton()
        nextBtn.backgroundColor = UIColor.lightGray
        nextBtn.titleLabel?.font = UIFont.BoldFont(15.0)
        self.nextBtn.isEnabled = false
        
        
        lblTitle.textColor = UIColor.textWhiteColor
        lblDesc.textColor = UIColor.themePrimaryColor
        
        self.btn1.setTitle("Volunteer", for: .normal)
        
    }
    
    @IBAction func groupBtnAction(_ sender: Any) {
        self.showGroupsPicker(list: ProcessUtils.shared.userGroupsList)
    }
    
    @IBAction func btnNextAction(_ sender: Any) {

//        if (ProcessUtils.shared.selectedUserGroup?.sjavms_RoleType?.sjavms_rolecategory == 802280000){
//
//            self.callbackToController?("volunteer", self)
//        }else if (ProcessUtils.shared.selectedUserGroup?.sjavms_RoleType?.sjavms_rolecategory == 802280001){
            
            self.callbackToController?("cslead", self)
//        }
    }
    
    func getGroups(){
        
        let params : [String:Any] = [
            ParameterKeys.select : "msnfp_groupmembershipid,msnfp_groupmembershipname,_msnfp_contactid_value,_msnfp_groupid_value",
            ParameterKeys.expand : "msnfp_groupId($select=msnfp_groupname),msnfp_contactId($select=fullname),sjavms_RoleType($select=sjavms_rolecategory)",
            ParameterKeys.filter : "(statecode eq 0 and _msnfp_contactid_value eq \(self.conId)) and (msnfp_groupId/statecode eq 0)",
            ParameterKeys.orderby : "_msnfp_groupid_value asc"
        ]
        
        self.getAssociatedGroups(params: params)
    }
    
    
    fileprivate func getAssociatedGroups(params:[String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestAssociatedGroups(params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result {
            case .success(let response):
                if let userGroups = response.value {
                    ProcessUtils.shared.userGroupsList = userGroups
                    
                    var propertyValues = ""
                    
                    for i in (0 ..< (ProcessUtils.shared.userGroupsList.count )){
                        var str = ""
                        
                        if let groupid_value = ProcessUtils.shared.userGroupsList[i]._msnfp_groupid_value {
                            
                            if ( i == (ProcessUtils.shared.userGroupsList.count) - 1){
                                str = "'{\(groupid_value)}'"
                            }else{
                                str = "'{\(groupid_value)}',"
                            }
                            propertyValues += str
                        }
                    }
                    ProcessUtils.shared.groupListValue = propertyValues
                    
                    if ProcessUtils.shared.userGroupsList.count == 0 {
                        DispatchQueue.main.async {
                            let button = UIButton()
                            self.volunteerTapped(button)
                        }
                    }else if let data = ProcessUtils.shared.userGroupsList.first, ProcessUtils.shared.userGroupsList.count == 1 {
                        DispatchQueue.main.async {
                            self.setSelectedGroup(data: data)
                        }
                    }
                    
                    
                }
                break
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
    
    
    func showGroupsPicker(list:[LandingGroupsModel] = []){
        if (ProcessUtils.shared.userGroupsList.count != 0){
            ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.groups, dataObj: ProcessUtils.shared.userGroupsList) { params, controller in
                
                if let data = params as? LandingGroupsModel {
                    self.setSelectedGroup(data: data)
                }
            }
        }else{
            self.getGroups()
        }
        
    }
    
    func setSelectedGroup(data:LandingGroupsModel){
        ProcessUtils.shared.selectedUserGroup = data
        
        self.btn2.setTitle("\(data.msnfp_groupId?.getGroupName() ?? "")", for: .normal)
//                self.btn1.setTitle(data.sjavms_RoleType?.getRoleType() ?? "", for: .normal)
        self.nextBtn.isEnabled = true
        self.nextBtn.backgroundColor = UIColor.themePrimary
    }

    @IBAction func volunteerTapped(_ sender: Any) {
        
        self.callbackToController?("volunteer", self)
    }
    
    
    
    
    
//    fileprivate func getGenderData(){
//
//        let params : [String:Any] = [
//            ParameterKeys.filter : "objecttypecode eq 'contact' and attributename eq 'sjavms_gender' and langid eq 1033",
//        ]
//
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//
//        ENTALDLibraryAPI.shared.requestAssociatedGroups(params: params) { result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//            switch result {
//            case .success(let response):
//                if let userGroups = response.value {
//                    ProcessUtils.shared.userGroupsList = userGroups
//
//                    var propertyValues = ""
//
//                    for i in (0 ..< (ProcessUtils.shared.userGroupsList.count )){
//                        var str = ""
//
//                        if let groupid_value = ProcessUtils.shared.userGroupsList[i]._msnfp_contactid_value {
//
//                            if ( i == (ProcessUtils.shared.userGroupsList.count) - 1){
//                                str = "'{\(groupid_value)}'"
//                            }else{
//                                str = "'{\(groupid_value)}',"
//                            }
//                            propertyValues += str
//                        }
//                    }
//                    ProcessUtils.shared.groupListValue = propertyValues
//                }
//                break
//            case .error(let error, let errorResponse):
//                var message = error.message
//                if let err = errorResponse {
//                    message = err.error
//                }
//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
//            }
//        }
//    }
    
    fileprivate func getGender() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "objecttypecode eq 'contact' and attributename eq 'sjavms_gender' and langid eq 1033"
        ]
    
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestProfileInfoDetail(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let genderData = response.value {
                    ProcessUtils.shared.genderData = genderData
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }

//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
    }
    
    
    fileprivate func getPrefferedNoun() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "objecttypecode eq 'contact' and attributename eq 'sjavms_preferredpronouns' and langid eq 1033"
        ]
    
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestProfileInfoDetail(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let genderData = response.value {
                    ProcessUtils.shared.prefferedPronounData = genderData
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }

//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
    }
    
    fileprivate func getPrefferedMethodContact() {
        
        let params : [String:Any] = [
            ParameterKeys.filter : "objecttypecode eq 'contact' and attributename eq 'preferredcontactmethodcode' and langid eq 1033"
        ]
    
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestProfileInfoDetail(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let genderData = response.value {
                    ProcessUtils.shared.prefferedMethodContactData = genderData
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }

//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
    }
      
    
    fileprivate func getPrefferedLanguage() {
        
        let params : [String:Any] = [
            ParameterKeys.select : "adx_portallanguageid,adx_name,createdon",
            ParameterKeys.expand : "adx_adx_portallanguage_adx_websitelanguage($filter=(_adx_websiteid_value eq 24684e99-f092-4556-8b54-060fd532e73b))",
            ParameterKeys.filter : "(adx_adx_portallanguage_adx_websitelanguage/any(o1:(o1/_adx_websiteid_value eq 24684e99-f092-4556-8b54-060fd532e73b)))",
            
            ParameterKeys.orderby : "adx_name asc"
            
        ]
    
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestPreferedLanguage(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let language = response.value {
                    ProcessUtils.shared.prefferedLanguageData = language
                }
                
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }

//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
    }
    
}
