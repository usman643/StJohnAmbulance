//
//  PendingShiftVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 27/01/2023.
//

import UIKit

class PendingShiftVC: ENTALDBaseViewController {

    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnSelectGroup: UIButton!
    @IBOutlet weak var btnGroupView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
 
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblShift: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PendingShiftTVC", bundle: nil), forCellReuseIdentifier: "PendingShiftTVC")
        
        decorateUI()
        
    }
    
    func decorateUI(){
        
        lblTitle.font = UIFont.BoldFont(20)
        lblSubTitle.font = UIFont.BoldFont(16)
        lblName.font = UIFont.BoldFont(12)
        lblName.font = UIFont.BoldFont(12)
        lblEvent.font = UIFont.BoldFont(12)
        lblDate.font = UIFont.BoldFont(12)
        lblHours.font = UIFont.BoldFont(12)
        lblShift.font = UIFont.BoldFont(12)
        lblAction.font = UIFont.BoldFont(12)
        
        lblTitle.textColor = UIColor.themePrimaryColor
        lblSubTitle.textColor = UIColor.themePrimaryColor
        lblName.textColor = UIColor.themePrimaryColor
        lblName.textColor = UIColor.themePrimaryColor
        lblEvent.textColor = UIColor.themePrimaryColor
        lblDate.textColor = UIColor.themePrimaryColor
        lblHours.textColor = UIColor.themePrimaryColor
        lblShift.textColor = UIColor.themePrimaryColor
        lblAction.textColor = UIColor.themePrimaryColor
        
        tableHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        tableHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
       
    }
    
    

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectGroupTapped(_ sender: Any) {
        
    }
    

    @IBAction func searchCloseTapped(_ sender: Any) {
        
    }
}


extension PendingShiftVC: UITableViewDelegate,UITableViewDataSource ,UITextViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingShiftTVC", for: indexPath) as! PendingShiftTVC
        if indexPath.row % 2 == 0{
            cell.mainView.backgroundColor = UIColor.hexString(hex: "e6f2eb")
            cell.dividerView.backgroundColor = UIColor.themePrimaryColor
        }else{
            cell.mainView.backgroundColor = UIColor.viewLightColor
            cell.dividerView.backgroundColor = UIColor.gray
        }
//        cell.lblName.text = "NAME"
//        cell.lblRole.text = "Role"
//        cell.lblCity.text = "City"
//        cell.lblState.text = "State"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
}
