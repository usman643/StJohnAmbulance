//
//  LocationManager.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 5/10/23.
//

import Foundation
import CoreLocation

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    static let defualt : LocationManager = LocationManager()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.pausesLocationUpdatesAutomatically = false
        manager.allowsBackgroundLocationUpdates = true
        manager.showsBackgroundLocationIndicator = true
        manager.activityType = .other
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    private override init() {
        
    }
    
    func startLocationUpdates(){
        locationManager.startUpdatingLocation()
    }
    
    func getRecentLocation() -> MapCoordsModel {
        let coords = locationManager.location?.coordinate
        let model = MapCoordsModel(lat: coords?.latitude ?? 0.0, lng: coords?.longitude ?? 0.0, name: "", pic: "")
       return model
    }
    
    func stopLocationUpdates(){
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
}

