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
}

class MapViewController: ENTALDBaseViewController {

    
    @IBOutlet weak var mapViewContainer: UIView!
    
    private lazy var mapView: GMSMapView = {
        let map = GMSMapView()
        return map
    }()
    
    let mapCoords : [MapCoordsModel] = [MapCoordsModel(lat: 45.27996209121132, lng: -66.06639728779841), MapCoordsModel(lat: 46.27996209121132, lng: -67.06639728779841),  MapCoordsModel(lat:48.27996209121132, lng: -69.06639728779841)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupMapView()
        // Creates a marker in the center of the map.
        
        for coords in self.mapCoords {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: coords.lat, longitude: coords.lng)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
