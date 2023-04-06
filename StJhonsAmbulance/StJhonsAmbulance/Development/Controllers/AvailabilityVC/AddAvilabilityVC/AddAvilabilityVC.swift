//
//  AddAvilabilityVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 06/04/2023.
//

import UIKit

protocol DayCloseDelegate {
    
    func dayClose(index:Int)
}

class AddAvilabilityVC: ENTALDBaseViewController , DayCloseDelegate {

    let days = ProcessUtils.shared.days
    var selectedDays : [Int] = []
    var datePicker = UIDatePicker()
    var dateEffectiveTo : String?
    var dateEffectiveFrom : String?
    let conId = UserDefaults.standard.contactIdToken ?? ""
    var selectedDaysStr = ""
    var action : String?
    var availability : AvailablityHourModel?
    
    @IBOutlet var lblAllTitle: [UILabel]!
    @IBOutlet weak var txtTitle: ACFloatingTextfield!
    @IBOutlet weak var txtEffectiveFrom: ACFloatingTextfield!
    @IBOutlet weak var txtEffectiveTo: ACFloatingTextfield!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnSelectDay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        decorateUI()
        
        self.availability = self.dataModel as? AvailablityHourModel
        
        if action == "edit"{
            setupData()
        }
        
        if #available(iOS 13.4, *) {
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        self.txtEffectiveFrom.tag = 1001
        self.txtEffectiveTo.tag = 1002
        self.txtEffectiveFrom.inputView = datePicker
        self.txtEffectiveTo.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(onChangeDate(_:)), for: .valueChanged)
       
    }
    
    func setupData(){
        
        txtTitle.text = self.availability?.msnfp_availabilitytitle
        if let date =  self.availability?.msnfp_effectivefrom {
            let start = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
            txtEffectiveFrom.text = start
        }else{
            txtEffectiveFrom.text = ""
        }
        
        if let date = self.availability?.msnfp_effectiveto {
            let end = DateFormatManager.shared.formatDateStrToStr(date: date, oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
            txtEffectiveTo.text = end
        }else{
            txtEffectiveTo.text = ""
        }
        var select = self.availability?.msnfp_workingdays?.components(separatedBy: ",")
        self.selectedDays =  select?.compactMap { Int($0) } ?? []
        
        self.collectionView.reloadData()
//        txtEffectiveFrom.text = self.availability?.msnfp_effectivefrom
//        txtEffectiveTo.text = self.availability?.msnfp_effectiveto
    }
    
    @objc func onChangeDate(_ sender: UIDatePicker){
        
        let date = datePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        if self.txtEffectiveFrom.isFirstResponder {
            //start date
            if #available(iOS 15.0, *) {
                self.txtEffectiveFrom.text = dateFormater.string(from: date)
                self.dateEffectiveFrom = date.ISO8601Format()
            } else {
                // Fallback on earlier versions
            }
        }else if self.txtEffectiveTo.isFirstResponder {
            //End date
            if #available(iOS 15.0, *) {
                self.txtEffectiveTo.text = dateFormater.string(from: date)
                self.dateEffectiveTo = date.ISO8601Format()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func registerCell(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "LanguageCVC", bundle: nil), forCellWithReuseIdentifier: "LanguageCVC")
    }
    
    func decorateUI(){
        
       for label in lblAllTitle{
           label.font = UIFont.BoldFont(14)
           label.textColor = UIColor.themePrimaryWhite
        }
                
        txtTitle.font = UIFont.SemiBoldFont(14)
        txtEffectiveFrom.font = UIFont.SemiBoldFont(14)
        txtEffectiveTo.font = UIFont.SemiBoldFont(14)
        txtTitle.textColor = UIColor.themePrimaryWhite
        txtEffectiveFrom.textColor = UIColor.themePrimaryWhite
        txtEffectiveTo.textColor = UIColor.themePrimaryWhite
        txtTitle.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEffectiveFrom.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtEffectiveTo.layer.borderColor = UIColor.themePrimaryWhite.cgColor
        txtTitle.layer.borderWidth = 1
        txtEffectiveFrom.layer.borderWidth = 1
        txtEffectiveTo.layer.borderWidth = 1
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        btnSubmit.titleLabel?.font = UIFont.BoldFont(14)
        btnSubmit.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectDay.titleLabel?.font = UIFont.BoldFont(14)
        btnSelectDay.setTitleColor(UIColor.textWhiteColor, for: .normal)
        btnSelectDay.setTitle("Select day", for: .normal)
    }

    @IBAction func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        if (self.txtTitle.text == ""){
            self.txtTitle.errorText = "Please Enter Title"
            return
        }
        if (self.txtEffectiveFrom.text == ""){
            self.txtEffectiveFrom.errorText = "Please Enter from title"
            return
        }
        if (self.txtEffectiveTo.text == ""){
            self.txtEffectiveTo.errorText = "Please Enter Effective to date"
            return
        }
        if self.action == "edit"{
            updateAvailability()
        }else{
            submitAvailability()
        }
    }
    
    
    
    @IBAction func btnSelectDay(_ sender: Any) {
        
        ENTALDControllers.shared.showSelectionPicker(type: .ENTALDPRESENT_OVER_CONTEXT, from: self, pickerType:.days, dataObj: self.days) { params, controller in
            
            if let data = params as? Int{
                
                let day = ProcessUtils.shared.getDay(code: data)
                self.btnSelectDay.setTitle(day, for: .normal)
                if (!self.selectedDays.contains(data)){
                    self.selectedDays.append(data)
                }
                
            }
                self.collectionView.reloadData()
                
            }
        }
    
    func dayClose(index:Int){
        
        self.selectedDays.remove(at: index)
        self.collectionView.reloadData()
    }
         
    func getdays()->String?{
        var dayStr = ""
        for day in self.selectedDays {
            
            if (day == self.selectedDays.last){
                dayStr += "\(day)"
            }else{
                dayStr += "\(day),"
            }
        }
        return dayStr
    }
    
    
    func submitAvailability(){
        
        let startDate = DateFormatManager.shared.formatDateStrToStrWithoutTimeZone(date: self.dateEffectiveFrom ?? "", oldFormat: "yyyy-MM-dd", newFormat: "yyyy-MM-dd")
        let endDate = DateFormatManager.shared.formatDateStrToStr(date: self.dateEffectiveTo ?? "", oldFormat: "yyyy-MM-dd", newFormat: "yyyy-MM-dd")
         
        let params : PostAddAvailabilityRequestModel = PostAddAvailabilityRequestModel(
            msnfp_availabilitytitle : self.txtTitle.text ?? "",
            msnfp_effectivefrom : "\(startDate)T00:00:00Z",
            msnfp_effectiveto :  "\(endDate)T00:00:00Z",
            msnfp_workingdays : self.getdays() ,
            msnfp_contactIdBindData : "/contacts(\(self.conId))"
        )
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        ENTALDLibraryAPI.shared.postAddAvailablity(params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result {
            case .success(_):
                self.callbackToController?(1, self)
                self.navigationController?.popViewController(animated: true)
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

    
    func updateAvailability(){
        
        let availabilityId = self.availability?.msnfp_availabilityid ?? ""
        let startDate =  DateFormatManager.shared.formatDateStrToStr(date: self.availability?.msnfp_effectivefrom ?? "" , oldFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
        let endDate = DateFormatManager.shared.formatDateStrToStr(date: self.availability?.msnfp_effectivefrom ?? "" , oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy-MM-dd")
         
        let params = [
            "msnfp_availabilitytitle" : (self.txtTitle.text ?? "") as String,
            "msnfp_effectivefrom"     : "\(startDate)T00:00:00Z" as String,
            "msnfp_effectiveto"       :  "\(endDate)T00:00:00Z" as String,
            "msnfp_workingdays"       : (self.getdays() ?? "")  as String,
            "msnfp_availabilityid"    : availabilityId as String
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.updateAvailability(availabilityid: availabilityId,  params: params) { result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                if let pastEvent = response.value {

                }else{
//                    self.showEmptyView(tableVw: self.tableView)
                }
                
            case .error(let error, let errorResponse):
                if error == .patchSuccess {
                    self.callbackToController?(1, self)
                    self.navigationController?.popViewController(animated: true)
                    break
                    
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






extension AddAvilabilityVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCVC", for: indexPath) as! LanguageCVC
        
        cell.lblTitle.text = ProcessUtils.shared.getDay(code: selectedDays[indexPath.row])
        
        
        cell.isFromAvailbility = true
        cell.index =  indexPath.row
        cell.dayDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSizeMake(130, 40)
    }
    
    
}
