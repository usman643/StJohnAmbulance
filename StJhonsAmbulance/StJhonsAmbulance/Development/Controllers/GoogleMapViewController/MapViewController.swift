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
        
        self.mapData = self.dataModel as! [CheckInModel]
        
        self.getMapData()
        // Do any additional setup after loading the view.
       
        // Creates a marker in the center of the map.
    }
    
    fileprivate func setupLocationPins(){
        for coords in self.mapCoords {
            let markerpic = UIImageView(image: ProcessUtils.shared.convertBase64StringToImage(imageBase64String: coords.pic ?? ""))
//            markerpic.layer.cornerRadius =  markerpic.layer.preferredFrameSize().height/2
//            markerpic.borderWidth = 0.5
//            markerpic.borderColor = UIColor.themePrimaryColor
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: coords.lat, longitude: coords.lng)
            marker.title = coords.name
            marker.snippet = "Canada"
            marker.map = mapView
            marker.iconView = markerpic
            marker.iconView?.fs_width = 30
            marker.iconView?.fs_height = 30
        }
    }
    
    fileprivate func setupMapView() {
        mapViewContainer.addSubview(mapView)
        mapViewContainer.addConstraintsWithFormat("H:|[v0]|", views: mapView)
        mapViewContainer.addConstraintsWithFormat("V:|[v0]|", views: mapView)
        
        let camera = GMSCameraPosition.camera(withLatitude: 45.27996209121132, longitude: -66.06639728779841, zoom: 6.0)
        mapView.camera = camera
    }
    

    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getMapData(){
        
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

}
