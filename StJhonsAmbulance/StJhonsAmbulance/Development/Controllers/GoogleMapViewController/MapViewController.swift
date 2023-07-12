//
//  MapViewController.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 5/10/23.
//

import UIKit
import GoogleMaps

struct MapCoordsModel {
    let lat : Double
    let lng : Double
    let name : String?
    let pic : String?
}

class MapViewController: ENTALDBaseViewController {

    var mapData : [CheckInModel] = []
    var latestEventIdData : [LatestEventModel]?
    var latestEventData : [LatestEventDataModel]?
    var checkInData : [CheckInModel]?
    var mapArr : [CheckInModel] = []
    @IBOutlet weak var mapViewContainer: UIView!
    
    private lazy var mapView: GMSMapView = {
        let map = GMSMapView()
        return map
    }()
    var mapCoords : [MapCoordsModel] = []
//    let mapCoords : [MapCoordsModel] = [MapCoordsModel(lat: 45.27996209121132, lng: -66.06639728779841, name: "", pic: ""), MapCoordsModel(lat: 46.27996209121132, lng: -67.06639728779841, name: "", pic: ""),  MapCoordsModel(lat:48.27996209121132, lng: -69.06639728779841, name: "", pic: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapView()
        
//        self.mapData = self.dataModel as! [CheckInModel]
        
//        self.getMapData()
        // Do any additional setup after loading the view.
       
        // Creates a marker in the center of the map.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.getLatestIncomingEvent()
    }
    
    fileprivate func setupLocationPins(){
        let camera = GMSCameraPosition.camera(withLatitude: 45.27996209121132, longitude: -66.06639728779841, zoom: 3.0)
        mapView.camera = camera
        
        for coords in self.mapCoords {
            let markerpic = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: coords.pic ?? "")
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: coords.lat, longitude: coords.lng)
            marker.map = mapView
            
            let mapView : MapPinView = MapPinView.fromNib()
            mapView.frame = CGRect(x: 0, y: 0, width: 105, height: 105)
//            MapPinView(frame: )
            mapView.pinTitle.text = coords.name
            mapView.pinIcon.image = markerpic
            marker.iconView = mapView
        }
    }
    
    fileprivate func setupMapView() {
        mapViewContainer.addSubview(mapView)
        mapViewContainer.addConstraintsWithFormat("H:|[v0]|", views: mapView)
        mapViewContainer.addConstraintsWithFormat("V:|[v0]|", views: mapView)
        
        let camera = GMSCameraPosition.camera(withLatitude: 45.27996209121132, longitude: -66.06639728779841, zoom: 3.0)

//        let camera = GMSCameraPosition.camera(withLatitude: 45.27996209121132, longitude: -66.06639728779841, zoom: 6.0)
        mapView.camera = camera
    }
    

    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getMapData(){
        self.mapCoords.removeAll()
        for i in (0..<self.mapData.count){
            
            for j in (0..<(self.mapData[i].sjavms_contact_msnfp_participationschedule_Volunteer?.count ?? 0)){
                
                if let lat = self.mapData[i].sjavms_contact_msnfp_participationschedule_Volunteer?[j].sjavms_checkedinlatitude, let lng = self.mapData[i].sjavms_contact_msnfp_participationschedule_Volunteer?[j].sjavms_checkedinlongitude{
                    
                    self.mapCoords.append(MapCoordsModel(lat: lat, lng: lng, name: "\(self.mapData[i].fullname ?? "")", pic: "\(self.mapData[i].entityimage ?? "")"))
                    break
                }
            }
        }
        
        self.setupLocationPins()
        
    }

    
    // API
    
    func getLatestIncomingEvent(){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "msnfp_engagementopportunitytitle,msnfp_engagementopportunitystatus,msnfp_needsreviewedparticipants,msnfp_minimum,msnfp_maximum,_sjavms_group_value,msnfp_endingdate,msnfp_cancelledparticipants,msnfp_appliedparticipants,msnfp_startingdate,msnfp_engagementopportunityid",
            ParameterKeys.expand : "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")])))",
                
              //  "sjavms_msnfp_engagementopportunity_msnfp_group($filter=(statecode eq 0 and Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")])))",
            ParameterKeys.filter : "(statecode eq 0) and (sjavms_msnfp_engagementopportunity_msnfp_group/any(o1:(o1/statecode eq 0 and o1/Microsoft.Dynamics.CRM.In(PropertyName='msnfp_groupid',PropertyValues=[\(ProcessUtils.shared.groupListValue ?? "")]))))",
            ParameterKeys.orderby : "msnfp_engagementopportunitytitle asc"
        ]
        
        self.getLatestIncomingEventData(params: params)
    }
    
    fileprivate func getLatestIncomingEventData(params : [String:Any]){
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestVolunteerLatestEventInfo(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                
                if let award = response.value {
                    self.latestEventIdData = award
                    
                    let dispatchQueue = DispatchQueue(label: "myQueu", qos: .background)
                    //Create a semaphore
                    let semaphore = DispatchSemaphore(value: 0)
                    
                    dispatchQueue.async {
                        for i in (0 ..< (self.latestEventIdData?.count ?? 0)){
                            self.getCheckInData(eventOppId: self.latestEventIdData?[i].msnfp_engagementopportunityid ?? "", completion:{ [weak self] model in
                                semaphore.signal()
                                guard let self = self else {return}
                                if let checkInData = model?.value {
                                    self.checkInData = checkInData
                                    if ((self.checkInData?.count ?? 0) > 0){
                                        self.mapData.append(contentsOf: (checkInData))
                                    }
                                }
                                
                            })
                            semaphore.wait()
                        }
                        
                        
                        DispatchQueue.main.async(execute: {
                            self.getMapData()
                            
                        })
                        
                        
                        //                        self.getIncomingEvent()
                        
                    }
                }
//                else{
//
//                        DispatchQueue.main.async {
//                            self.collectionview.reloadData()
//                        }
//                    }
                
                
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
    
//    func getIncomingEvent(){
//
//              var propertyValues = ""
//
//                for i in (0 ..< (self.latestEventIdData?.count ?? 0)){
//                    var str = ""
//
//                    if let groupid_value = self.latestEventIdData?[i].msnfp_engagementopportunityid {
//
//                        if ( i == (self.latestEventIdData?.count ?? 0) - 1){
//                            str = "'{\(groupid_value)}'"
//                        }else{
//                            str = "'{\(groupid_value)}',"
//                        }
//
//                        propertyValues += str
//                    }
//
//
//                }
//
//        guard let contactId = UserDefaults.standard.contactIdToken  else {return}
//        guard let currentDate = DateFormatManager.shared.getCurrentDateWithFormat(format: "yyyy-MM-dd") else {return}
//        let params : [String:Any] = [
//
//            ParameterKeys.select : "msnfp_name,msnfp_participationscheduleid,statuscode,statecode,msnfp_schedulestatus,sjavms_start,sjavms_end",
//            ParameterKeys.expand : "sjavms_VolunteerEvent($select=msnfp_engagementopportunitytitle,msnfp_location)",
//
//            ParameterKeys.filter : "(_sjavms_volunteer_value eq \(contactId) and msnfp_schedulestatus eq 335940000 and Microsoft.Dynamics.CRM.OnOrAfter(PropertyName='sjavms_end',PropertyValue='\(currentDate)') and Microsoft.Dynamics.CRM.In(PropertyName='sjavms_volunteerevent',PropertyValues=[\(propertyValues)]))",
//            ParameterKeys.orderby : "msnfp_name asc"
//        ]
//
//        self.getVolunteerIncomingData(params: params)
//    }
//
//    fileprivate func getVolunteerIncomingData(params : [String:Any]){
//        DispatchQueue.main.async {
//            LoadingView.show()
//        }
//
//        ENTALDLibraryAPI.shared.requestVolunteerLatestEvents(params: params){ result in
//            DispatchQueue.main.async {
//                LoadingView.hide()
//            }
//
//            switch result{
//            case .success(value: let response):
//
//
////                    var index = NSNotFound
////                    for i in (0..<(self.gridData?.count ?? 0 )){
////                        if (self.gridData?[i].key ==  "sjavms_youthcamp"){
////                            index = i
////                        }
////                    }
//
//                    if let award = response.value {
//                        self.latestEventData = award
//                        if ((self.latestEventData?.count ?? 0 ) > 0){
////                            self.gridData?[index].title = self.latestEventData?[0].sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle
//                            if (self.latestEventData?[0].sjavms_start != nil && self.latestEventData?[0].sjavms_start != ""){
//                                let startData = DateFormatManager.shared.formatDateStrToStr(date: self.latestEventData?[0].sjavms_start ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", newFormat: "yyyy/MM/dd")
////                                self.gridData?[index].subTitle = startData
////                                self.collectionview.reloadData()
//                            }
////                            else{
////                                self.gridData?[index].subTitle  = ""
////                            }
//                        }
////                        else{
////                            DispatchQueue.main.async {
////                                self.gridData?[index].title  = "No Upcoming Event"
////                                self.collectionview.reloadData()
////                            }
////                        }
//                    }else{
////                        DispatchQueue.main.async {
////                            self.gridData?[index].title  = "No Upcoming Event"
////                            self.collectionview.reloadData()
////                        }
//                    }
//
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
//
    
    
    
    
    fileprivate func getCheckInData(eventOppId:String, completion:@escaping((_ model : CheckInResponseModel?) -> Void )){
        
        let params : [String:Any] = [
            
            ParameterKeys.select : "fullname,telephone1,_ownerid_value,emailaddress1,bdo_province,address1_postalcode,address1_city,bdo_contactid,_parentcustomerid_value,contactid,entityimage",
            ParameterKeys.expand : "sjavms_contact_msnfp_participationschedule_Volunteer($select=sjavms_checkedin,sjavms_checkedinlatitude,sjavms_checkedinlongitude,sjavms_checkedinat,sjavms_checkedinlocation;$filter=(_sjavms_volunteerevent_value eq \(eventOppId) and msnfp_schedulestatus eq 335940000))",
            ParameterKeys.filter : "(sjavms_contact_msnfp_participationschedule_Volunteer/any(o1:(o1/_sjavms_volunteerevent_value eq \(eventOppId) and o1/msnfp_schedulestatus eq 335940000)))",
            ParameterKeys.orderby : "fullname asc"
        ]
        
        DispatchQueue.main.async {
            LoadingView.show()
        }
        
        ENTALDLibraryAPI.shared.requestCheckInData(params: params){ result in
            DispatchQueue.main.async {
                LoadingView.hide()
            }
            
            switch result{
            case .success(value: let response):
                completion(response)
                
//                if let checkInData = response.value {
//                    self.checkInData = checkInData
//                    if ((self.checkInData?.count ?? 0) > 0){
//                        self.mapData.append(contentsOf: (checkInData))
//                    }
//                }
                
            case .error(let error, let errorResponse):
//                completion(nil)
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                print("Error Message \(message)")
            }
        }
    }
}
