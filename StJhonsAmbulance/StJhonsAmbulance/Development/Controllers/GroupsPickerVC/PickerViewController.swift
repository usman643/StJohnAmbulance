//
//  PickerViewController.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/25/23.
//

import UIKit

enum STPikerType {
    case groups
    case gender
    case pronoun
    case prefferedData
    case optNotification
    case eventProvince
    case eventBranch
    case eventCouncil
    case language
    case prefferedLanguage
    case eventStatus
    case days
    case adhocHourEvent
    case nonAdhocHourEvent
    case therapyDogID
    case therapyDogFacility

}

class PickerViewController: ENTALDBaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneBtn: UIButton!
    
    var pickerType : STPikerType = .groups
    var selectedIndex : Int = 0
    var selectedKey : String = ""
    private var dataList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.dataList = self.setDataFromObject()
        self.pickerView.reloadAllComponents()
        
        // Do any additional setup after loading the view.
    }
    
    func setDataFromObject()->[String]{
        
        switch self.pickerType {
        case .groups:
            if let model = self.dataModel as? [LandingGroupsModel] {
                return model.map({$0.msnfp_groupId?.msnfp_groupname ?? ""})
            }
            break
        case .gender, .pronoun, .prefferedData:
            if let model = self.dataModel as? [LanguageModel] {
                return model.map({$0.value ?? ""})
            }
            break
        case .optNotification:
            if let model = self.dataModel as? [Int:String] {
                return model.map({$0.value })
            }
            break
        case .eventProvince:
            if let model = self.dataModel as? [EventProgramDataModel] {
                return model.map({$0.sjavms_Program?.sjavms_name ?? ""})
            }
            break
        case .eventBranch:
            if let model = self.dataModel as? [EventBranchModel] {
                return model.map({$0.sjavms_name ?? ""})
            }
            break
        case .eventCouncil:
            if let model = self.dataModel as? [EventCouncilModel] {
                return model.map({$0.sjavms_name ?? ""})
            }
        case .language:
            if let model = self.dataModel as? [LanguageModel] {
                return model.map({$0.value ?? ""})
            }
        case .prefferedLanguage:
            if let model = self.dataModel as? [PrefferedLanguageModel] {
                return model.map({$0.adx_name ?? ""})
            }
        case .eventStatus:
            if let model = self.dataModel as? [Int:String] {
                return model.map({$0.value })
            }
        case .days:
            if let model = self.dataModel as? [Int:String] {
                return model.map({$0.value })
            }
        case .adhocHourEvent:
            if let model = self.dataModel as? [AdhocHourVolunteerEventModel] {
                return model.map({$0.msnfp_engagementopportunitytitle ?? "" })
            }
        case .nonAdhocHourEvent:
            if let model = self.dataModel as? [NonAdhocHourVolunteerEventModel] {
                return model.map({$0.msnfp_engagementopportunitytitle ?? ""})
            }
          
        case .therapyDogID:
            if let model = self.dataModel as? [TherapyDogIdModel] {
                return model.map({$0.sjavms_name ?? ""})
            }
          
        case .therapyDogFacility:
            if let model = self.dataModel as? [TherapyDogFacilityModel] {
                return model.map({$0.name ?? ""})
            }
            break
        }
        
        return []
    }
    
    

    @IBAction func btnDoneAction(_ sender: Any) {
        let data = self.getSelectedValue()
        self.callbackToController?(data, self)
        self.dismiss(animated: true)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedIndex = row
        self.selectedKey = self.dataList[row]
    }
    
    func getSelectedValue()->Any?{
        switch pickerType {
        case .groups:
            if let model = self.dataModel as? [LandingGroupsModel] {
                return model[self.selectedIndex]
            }
        case .gender, .pronoun, .prefferedData:
            if let model = self.dataModel as? [LanguageModel] {
                return model[self.selectedIndex]
            }
            break
        case .optNotification:
            if let model = self.dataModel as? [Int:String] {
                let key = model.filter({$0.value == selectedKey}).first?.key ?? NSNotFound
                return model[key]
            }
            break
        case .eventProvince:
            if let model = self.dataModel as? [EventProgramDataModel] {
                return model[self.selectedIndex]
            }
            break
        case .eventBranch:
            if let model = self.dataModel as? [EventBranchModel] {
                return model[self.selectedIndex]
            }
            break
        case .eventCouncil:
            if let model = self.dataModel as? [EventCouncilModel] {
                return model[self.selectedIndex]
            }
            break
        case .language:
            if let model = self.dataModel as? [LanguageModel] {
                return model[self.selectedIndex]
            }
            break
        case .prefferedLanguage:
            if let model = self.dataModel as? [PrefferedLanguageModel] {
                return model[self.selectedIndex]
            }
        case .eventStatus:
            if let model = self.dataModel as? [Int:String] {
                let key = model.filter({$0.value == selectedKey}).first?.key ?? NSNotFound
                return model[key]
            }
        case .days:
            if let model = self.dataModel as? [Int:String] {
                let key = model.filter({$0.value == selectedKey}).first?.key ?? NSNotFound
                return key
            }
        case .adhocHourEvent:
            if let model = self.dataModel as? [AdhocHourVolunteerEventModel] {
                return model[self.selectedIndex]
            }
        case .nonAdhocHourEvent:
            if let model = self.dataModel as? [NonAdhocHourVolunteerEventModel] {
                return model[self.selectedIndex]
            }
        case .therapyDogID:
            if let model = self.dataModel as? [TherapyDogIdModel] {
                return model[self.selectedIndex]
            }
        case .therapyDogFacility:
            if let model = self.dataModel as? [TherapyDogFacilityModel] {
                return model[self.selectedIndex]
            }
            break
        }
        
        return nil
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
