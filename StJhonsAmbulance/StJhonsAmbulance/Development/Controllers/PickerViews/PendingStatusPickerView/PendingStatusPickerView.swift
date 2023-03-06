//
//  PendingStatusPickerView.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 05/03/2023.
//

import UIKit

class PendingStatusPickerView:  ENTALDBaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var cancelBtn: NSLayoutConstraint!
    
    var statusList : [Int] = []
    var selectedStatus : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.selectedStatus = statusList.count > 0 ? statusList.first : nil
        self.statusList = ProcessUtils.shared.getPendingShiftStatus()
        self.pickerView.reloadAllComponents()
//        if let dlist = self.dataModel as? [PendingShiftModelTwo] {
//
//        }
        // Do any additional setup after loading the view.
    }

    @IBAction func btnDoneAction(_ sender: Any) {
        self.callbackToController?(self.selectedStatus, self)
        self.dismiss(animated: true)
    }
    
    
    @IBAction func btnCancelAction(_ sender: Any) {
//        self.callbackToController?("", self)
        self.dismiss(animated: true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.statusList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return ProcessUtils.shared.getStatus(code: self.statusList[row] )
//        return self.statusList[row].msnfp_groupId?.msnfp_groupname
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (self.statusList.count != 0){
            self.selectedStatus = self.statusList[row]
        }
    }

}
