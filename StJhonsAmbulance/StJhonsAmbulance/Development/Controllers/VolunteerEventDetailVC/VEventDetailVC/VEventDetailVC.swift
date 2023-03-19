//
//  VEventDetailVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 19/03/2023.
//

import UIKit

class VEventDetailVC: ENTALDBaseViewController {
    
    var detailData : [VolunteerEventClickShiftDetailModel]?
    var eventId : String?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblQualificationTitle: UILabel!
    @IBOutlet weak var lblQualification: UILabel!
    @IBOutlet weak var lblLocationTitle: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.decorateUI()
        self.getEventDetail()
    }

    
    
    func decorateUI(){
        
        lblTitle.textColor = UIColor.themePrimaryColor
        lblQualification.textColor = UIColor.themePrimaryColor
        lblLocation.textColor = UIColor.themePrimaryColor
        lblQualificationTitle.textColor = UIColor.textBlackColor
        lblLocationTitle.textColor = UIColor.textBlackColor
        
        lblTitle.font = UIFont.BoldFont(14)
        lblQualification.font = UIFont.BoldFont(14)
        lblLocation.font = UIFont.BoldFont(14)
        lblQualificationTitle.font = UIFont.BoldFont(16)
        lblLocationTitle.font = UIFont.BoldFont(16)
    
    }
 
    func getEventDetail() {
        
        let params : [String:Any] = [
            ParameterKeys.select : "msnfp_location,msnfp_engagementopportunitytitle,msnfp_shortdescription,msnfp_qualifications,msnfp_startingdate,msnfp_locationname,msnfp_shifts,msnfp_locationcitystate",
            ParameterKeys.filter : "(_msnfp_engagementopportunityid_value eq \(self.eventId ?? ""))"
        ]
        
        self.getEventDetailData(params: params)
        
    }
    
    
    fileprivate func getEventDetailData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerEventClickShiftDetail(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            switch result{
            case .success(value: let response):
                
                if let qualification = response.value {
                    self.detailData = qualification
                    
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
    
    func setupData(){
        self.lblLocation.text = self.detailData?[0].msnfp_location ?? ""
        self.lblQualification.text = "None"
        self.lblTitle.text = self.detailData?[0].msnfp_shortdescription ?? ""
    }

}
