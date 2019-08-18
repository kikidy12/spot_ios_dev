//
//  AlienceMapViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import GoogleMaps

class AlienceMapViewController: UIViewController {
    
    var categoryType: AlienceTitles!

    override func viewDidLoad() {
        super.viewDidLoad()
        let latCenter = (40.712216 + 40.773941)/2
        let longCenter = (-74.22655 + -74.12544)/2
        let camera = GMSCameraPosition.camera(withLatitude: latCenter, longitude: longCenter, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView.delegate = self
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latCenter, longitude: longCenter)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        let southWest = CLLocationCoordinate2D(latitude: 40.712216, longitude: -74.22655)
        let northEast = CLLocationCoordinate2D(latitude: 40.773941, longitude: -74.12544)
        let overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
        
        // Image from http://www.lib.utexas.edu/maps/historical/newark_nj_1922.jpg
        let icon = UIImage(named: "google_login")
        
        let overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
        overlay.bearing = 0
        overlay.map = mapView
    }

}

extension AlienceMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let testView = UIView(frame: .init(x: 0, y: 0, width: 150, height: 100))
        testView.backgroundColor = .red
        return testView
    }
}
