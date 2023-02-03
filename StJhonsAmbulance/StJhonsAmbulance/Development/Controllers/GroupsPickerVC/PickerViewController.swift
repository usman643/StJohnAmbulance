//
//  PickerViewController.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 1/25/23.
//

import UIKit

class PickerViewController: ENTALDBaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneBtn: UIButton!
    
    var groupsList : [LandingGroupsModel] = []
    var selectedGroup : LandingGroupsModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.selectedGroup = groupsList.count > 0 ? groupsList.first : nil
        
        if let dlist = self.dataModel as? [LandingGroupsModel] {
            self.groupsList = dlist
            self.pickerView.reloadAllComponents()
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func btnDoneAction(_ sender: Any) {
        self.callbackToController?(self.selectedGroup, self)
        self.dismiss(animated: true)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.groupsList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.groupsList[row].msnfp_groupId?.msnfp_groupname
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (self.groupsList.count != 0){
            self.selectedGroup = self.groupsList[row]
        }
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
