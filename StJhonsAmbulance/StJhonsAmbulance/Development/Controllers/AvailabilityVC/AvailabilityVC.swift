//
//  AvailabilityVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 15/02/2023.
//

import UIKit

class AvailabilityVC: UIViewController {

    
//    var adhocData : []?
//    var volunteerHourData : []?
//    var availablityData : []?
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var allHeadingLabel: [UILabel]!
    
    @IBOutlet weak var adhocHeaderView: UIView!
    @IBOutlet weak var voluteerHourHeaderView: UIView!
    @IBOutlet weak var availablityHeaderView: UIView!
    @IBOutlet var allTableHeadingLabel: [UILabel]!
  
    
    @IBOutlet weak var adhocTableView: UITableView!
    @IBOutlet weak var voluteerHourTableView: UITableView!
    @IBOutlet weak var availablityTableView: UITableView!
    
    @IBOutlet weak var lblPending: UILabel!
    @IBOutlet weak var lblYeartoDate: UILabel!
    @IBOutlet weak var lblLifeTime: UILabel!
    
    @IBOutlet weak var lblTabTitle: UILabel!
    @IBOutlet weak var selectedTabImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateUI()
    }
    
    func registerCell(){
//        adhocTableView.delegate = self
//        voluteerHourTableView.delegate = self
//        availablityTableView.delegate = self
//        adhocTableView.dataSource = self
//        voluteerHourTableView.dataSource = self
//        availablityTableView.dataSource = self
//        adhocTableView.register(UINib(nibName: "AdhocHourTVC", bundle: nil), forCellReuseIdentifier: "AdhocHourTVC")
//        voluteerHourTableView.register(UINib(nibName: "VolunteerHourAvailabilityTVC", bundle: nil), forCellReuseIdentifier: "VolunteerHourAvailabilityTVC")
//        availablityTableView.register(UINib(nibName: "VolunteerHourAvailabilityTVC", bundle: nil), forCellReuseIdentifier: "VolunteerHourAvailabilityTVC")
    }
    
    func setupContent(){
        lblPending.text = UserDefaults.standard.userInfo?.sjavms_totalpendinghrs?.getFormattedNumber()
        lblYeartoDate.text = UserDefaults.standard.userInfo?.sjavms_totalhourscompletedthisyear?.getFormattedNumber()
        lblLifeTime.text = UserDefaults.standard.userInfo?.msnfp_totalengagementhours?.getFormattedNumber()
    }

    func decorateUI(){
        
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        
        adhocHeaderView.layer.borderWidth = 1
        adhocHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        availablityHeaderView.layer.borderWidth = 1
        availablityHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        voluteerHourHeaderView.layer.borderWidth = 1
        voluteerHourHeaderView.layer.borderColor = UIColor.themePrimaryColor.cgColor
        
        
        for lbltext in allTableHeadingLabel{
            lbltext.font = UIFont.BoldFont(12)
            lbltext.textColor = UIColor.themePrimaryColor
        }
        
        for lbltext in allHeadingLabel{
            lbltext.font = UIFont.BoldFont(14)
            lbltext.textColor = UIColor.themeBlackText
        }
        
        
        lblTabTitle.textColor = UIColor.themePrimaryColor
        lblTabTitle.font = UIFont.BoldFont(16)
        
        selectedTabImg.image = selectedTabImg.image?.withRenderingMode(.alwaysTemplate)
        selectedTabImg.tintColor = UIColor.themePrimaryColor
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
    
    }
    
    @IBAction func adhocFilterTapped(_ sender: Any) {
//        self.adhocData = self.adhocData?.reversed()
//        DispatchQueue.main.async {
//            self.adhocTableView.reloadData()
//        }
        
    }
    
    @IBAction func volunteerFilterTapped(_ sender: Any) {
//        self.volunteerHourData = self.volunteerHourData?.reversed()
//        DispatchQueue.main.async {
//            self.voluteerHourTableView .reloadData()
//        }
    }
    
    @IBAction func availablityFilterTapped(_ sender: Any) {
//        self.availablityData = selfavailablityDatanonEventData?.reversed()
//        DispatchQueue.main.async {
//            self.availablityTableView.reloadData()
//        }
    }


    
    
}

//extension AvailabilityVC : UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (tableView == self.adhocTableView){
//            return adhocData?.count ?? 0
//        }else if (tableView == voluteerHourTableView){
//            return volunteerHourData?.count ?? 0
//        }else if (tableView == availablityTableView){
//            return availablityData?.count ?? 0
//        }
//
//        return 0
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//        if (tableView == self.adhocTableView){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AdhocHourTVC", for: indexPath) as! AdhocHourTVC
//
//            if indexPath.row % 2 == 0{
//                cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
//                cell.seperatorView.backgroundColor = UIColor.themePrimaryColor
//            }else{
//                cell.backgroundColor = UIColor.viewLightColor
//                cell.seperatorView.backgroundColor = UIColor.gray
//            }
//
//            let rowModel = self.adhocData?[indexPath.row]
//            cell.setContent(cellModel: rowModel)
//            return cell
//
//        }else if (tableView == voluteerHourTableView){
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteerHourAvailabilityTVC", for: indexPath) as! VolunteerHourAvailabilityTVC
//
//            if indexPath.row % 2 == 0{
//                cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
//                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
//            }else{
//                cell.backgroundColor = UIColor.viewLightColor
//                cell.seperaterView.backgroundColor = UIColor.gray
//            }
//            let rowModel = self.volunteerHourData?[indexPath.row]
//            cell.setContent(cellModel: rowModel)
//            return cell
//
//        }else if (tableView == availablityTableView){
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailabilityTVC", for: indexPath) as! AvailabilityTVC
//
//            if indexPath.row % 2 == 0{
//                cell.backgroundColor = UIColor.hexString(hex: "e6f2eb")
//                cell.seperaterView.backgroundColor = UIColor.themePrimaryColor
//            }else{
//                cell.backgroundColor = UIColor.viewLightColor
//                cell.seperaterView.backgroundColor = UIColor.gray
//            }
//            let rowModel = self.availablityData?[indexPath.row]
//            cell.setContent(cellModel: rowModel)
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailabilityTVC", for: indexPath) as! AvailabilityTVC
//            return cell
//        }
//
//
//    }
//}
