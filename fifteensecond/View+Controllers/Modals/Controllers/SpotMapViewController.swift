//
//  SpotMapViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 02/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps
import GooglePlaces

class SpotMapViewController: UIViewController {
    
    var mapView: GMSMapView!
    var selectSpot:SpotDatas!
    let locationManager = CLLocationManager()
    
    var markerList = [[GMSMarker:SpotDatas]]()
    
    var spotList = [SpotDatas]() {
        didSet {
            markerList = spotList.compactMap {
                let marker = GMSMarker()
                marker.position = $0.location
                marker.map = mapView
                marker.icon = #imageLiteral(resourceName: "spotMarker")
                marker.setIconSize(scaledToSize: CGSize(width: 60, height: 65))
                return [marker:$0]
            }
        }
    }
    
    @IBOutlet weak var mapContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let latCenter = 37.562899
        let longCenter = 127.064770
        mapView = GMSMapView(frame: mapContainerView.bounds)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        if let loc = locationManager.location?.coordinate {
            let camera = GMSCameraPosition.camera(withLatitude: loc.latitude, longitude: loc.longitude, zoom: 15.0)
            mapView.camera = camera
        }
        else {
            let camera = GMSCameraPosition.camera(withLatitude: latCenter, longitude: longCenter, zoom: 15.0)
            mapView.camera = camera
        }
        
        mapContainerView.addSubview(mapView)
        mapView.delegate = self
        locationManager.delegate = self
        
        getSpotList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "15Seconds"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
}

extension SpotMapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let infoView = SpotMarkerInfoWindowView(frame: .init(x: 0, y: 0, width: 242, height: 153))
        if let spot = markerList.first(where: {$0.keys.first == marker})?.values.first {
            infoView.initView(spot)
        }
        
        return infoView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let spot = markerList.first(where: {$0.keys.first == marker})?.values.first {
//            selectSpot = spot
//            let vc = HasSpotTicketListViewController()
//            vc.spot = spot
            let vc = UseSpotTicketViewController()
            vc.spot = spot
            show(vc, sender: nil)
        }
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        marker.setIconSize(scaledToSize: CGSize(width: 60, height: 65))
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        marker.setIconSize(scaledToSize: CGSize(width: 70, height: 78))
        return false
    }
}


extension SpotMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}

extension SpotMapViewController {
    func getSpotList() {
        guard let lat = locationManager.location?.coordinate.latitude, let lng = locationManager.location?.coordinate.longitude else { return }
        let parameters = [
            "latitude": lat,
            "longitude": lng
        ] as Parameters
        ServerUtil.shared.getSpot(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["spot"] as? NSArray else { return }
            
            self.spotList = array.compactMap { SpotDatas($0 as! NSDictionary) }
        }
    }
}
