//
//  AlienceMapViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps
import GooglePlaces

class AlienceMapViewController: UIViewController {
    
    var categoryType: AlienceTitles!
    
    var place: GMSPlacesClient!
    
    let locationManager = CLLocationManager()
    
    var markerList = [[GMSMarker:Any]]() {
        didSet {
            print("count", markerList.count)
        }
    }
    
    var restaurantList = [RestaurantDatas]() {
        didSet {
            markerList = restaurantList.compactMap {
                let marker = GMSMarker()
                marker.position = $0.location
                marker.map = mapView
                if $0.promotionCount != 0 || !$0.isOpend {
                    marker.icon = #imageLiteral(resourceName: "restaurantMarker")
                }
                else {
                    marker.icon = #imageLiteral(resourceName: "npRestaurantMapIcon")
                }
                
                marker.setIconSize(scaledToSize: CGSize(width: 40, height: 42))
                return [marker:$0]
            }
        }
    }
    
    var shoppingList = [ShoppingDatas]() {
        didSet {
            markerList = shoppingList.compactMap {
                let marker = GMSMarker()
                marker.position = $0.location
                marker.map = mapView
                if $0.promotionCount != 0 {
                    marker.icon = #imageLiteral(resourceName: "shoppingMarker")
                }
                else {
                    marker.icon = #imageLiteral(resourceName: "shoppingMarker")
                }
                marker.setIconSize(scaledToSize: CGSize(width: 40, height: 42))
                return [marker:$0]
            }
        }
    }
    
    var ticketList = [TicketDatas]() {
        didSet {
            markerList = ticketList.compactMap {
                let marker = GMSMarker()
                marker.position = $0.location
                marker.map = mapView
                if $0.promotionCount != 0 {
                    marker.icon = #imageLiteral(resourceName: "ticketMarker")
                }
                else {
                    marker.icon = #imageLiteral(resourceName: "npTicketMapIcon")
                }
                marker.setIconSize(scaledToSize: CGSize(width: 40, height: 42))
                return [marker:$0]
            }
        }
    }
    
    var hotelList = [HotelDatas]() {
        didSet {
            markerList = hotelList.compactMap {
                let marker = GMSMarker()
                marker.position = $0.location
                marker.map = mapView
                if $0.promotionCount != 0 {
                    marker.icon = #imageLiteral(resourceName: "hotelMarker")
                }
                else {
                    marker.icon = #imageLiteral(resourceName: "hotelMarker")
                }
                marker.setIconSize(scaledToSize: CGSize(width: 40, height: 42))
                return [marker:$0]
            }
        }
    }
    
    var playList = [PlayDatas]() {
        didSet {
            markerList = playList.compactMap {
                let marker = GMSMarker()
                marker.position = $0.location
                marker.map = mapView
                if $0.promotionCount != 0 || !$0.isOpend {
                    marker.icon = #imageLiteral(resourceName: "playMapIcon")
                }
                else {
                    marker.icon = #imageLiteral(resourceName: "npPlayMapIcon")
                }
                marker.setIconSize(scaledToSize: CGSize(width: 40, height: 42))
                return [marker:$0]
            }
        }
    }
    
    var beautyList = [BeautyDatas]() {
            didSet {
                markerList = beautyList.compactMap {
                    let marker = GMSMarker()
                    marker.position = $0.location
                    marker.map = mapView
                    if $0.promotionCount != 0 || !$0.isOpend {
                        marker.icon = #imageLiteral(resourceName: "beautyMapIcon")
                    }
                    else {
                        marker.icon = #imageLiteral(resourceName: "npBeautyMapIcon")
                    }
                    marker.setIconSize(scaledToSize: CGSize(width: 40, height: 42))
                    return [marker:$0]
                }
            }
        }
    
    @IBOutlet weak var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let latCenter = 37.562899
        let longCenter = 127.064770
        
        if let loc = locationManager.location?.coordinate {
            let camera = GMSCameraPosition.camera(withLatitude: loc.latitude, longitude: loc.longitude, zoom: 15.0)
            mapView.camera = camera
        }
        else {
            let camera = GMSCameraPosition.camera(withLatitude: latCenter, longitude: longCenter, zoom: 15.0)
            mapView.camera = camera
        }
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        locationManager.delegate = self
        getAliences()
    }

}

extension AlienceMapViewController: GMSMapViewDelegate {
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        let camera = GMSCameraPosition.camera(withTarget: mapView.myLocation!.coordinate, zoom: 15)
        mapView.camera = camera
        
        return true
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let infoView = CustomMarkerInfoWindowView(frame: .init(x: 0, y: 0, width: 263, height: 153))
        if let currentDict = markerList.first(where: {$0.keys.first == marker}) {
            infoView.initView(data: currentDict.values.first!)
        }
        
        return infoView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let currentDict = markerList.first(where: {$0.keys.first == marker}) {
            guard let data = currentDict.values.first else { return }
            parent?.title = categoryType.rawValue
            if let resaturant = data as? RestaurantDatas {
                let vc = AlienceInfoListViewController()
                vc.alienceId = resaturant.id
                vc.type = .restaurant
                self.show(vc, sender: nil)
            }
            else if let ticket = data as? TicketDatas {
                let vc = AlienceInfoListViewController()
                vc.alienceId = ticket.id
                vc.type = .tickets
                self.show(vc, sender: nil)
            }
            
            else if let shopping = data as? ShoppingDatas {
                let vc = AlienceInfoListViewController()
                vc.alienceId = shopping.id
                vc.type = .shopping
                self.show(vc, sender: nil)
            }
            
            else if let hotel = data as? HotelDatas {
                let vc = AlienceInfoListViewController()
                vc.alienceId = hotel.id
                vc.type = .hotel
                self.show(vc, sender: nil)
            }
            
            else if let play = data as? PlayDatas {
                let vc = AlienceInfoListViewController()
                vc.alienceId = play.id
                vc.type = .play
                self.show(vc, sender: nil)
            }
            
            else if let beauty = data as? BeautyDatas {
                let vc = AlienceInfoListViewController()
                vc.alienceId = beauty.id
                vc.type = .beauty
                self.show(vc, sender: nil)
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        marker.setIconSize(scaledToSize: CGSize(width: 40, height: 42))
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        marker.setIconSize(scaledToSize: CGSize(width: 50, height: 54))
        return false
    }
}

extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}

extension AlienceMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}

extension AlienceMapViewController {
    
    func getAliences() {
        guard let type = categoryType else { return }
        guard let location = locationManager.location?.coordinate else { return }
        let parameters = [
            "latitude": location.latitude,
            "longitude": location.longitude,
            "sort_type": "name",
            "category_id": 0
            ] as Parameters
        ServerUtil.shared.getAliences(self, type: type, parameters: parameters) { (success, dict, message) in
            guard success, let data = dict else { return }
            
            switch type {
            case .restaurant:
                if let array = data["restaurant"] as? NSArray {
                    self.restaurantList = array.compactMap { RestaurantDatas($0 as! NSDictionary) }
                }
                break
            case .shopping:
                if let array = data["shopping_mall"] as? NSArray {
                    self.shoppingList = array.compactMap { ShoppingDatas($0 as! NSDictionary) }
                }
                break
            case .tickets:
                if let array = data["ticket"] as? NSArray {
                    self.ticketList = array.compactMap { TicketDatas($0 as! NSDictionary) }
                }
                break
            case .hotel:
                if let array = data["hotel"] as? NSArray {
                    self.hotelList = array.compactMap { HotelDatas($0 as! NSDictionary) }
                }
                break
            case .play:
                if let array = data["play"] as? NSArray {
                    self.playList = array.compactMap { PlayDatas($0 as! NSDictionary) }
                }
                break
            case .beauty:
                if let array = data["beauty"] as? NSArray {
                    self.beautyList = array.compactMap { BeautyDatas($0 as! NSDictionary) }
                }
                break
            }
            
        }
    }
}

