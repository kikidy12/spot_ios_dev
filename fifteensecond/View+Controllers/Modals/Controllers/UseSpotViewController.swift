//
//  UseSpotViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/10/21.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import MobileCoreServices

class UseSpotViewController: UIViewController {
    
    var controller = UIImagePickerController()
    let videoFileName = "/video.mp4"
    var videoURL: URL!
    
    var spot: SpotDatas!
    var code = ""
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard spot != nil else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        locationNameLabel.text = "이용지점 : \(spot.name ?? "미확인")"
        countLabel.text = "\(spot.count ?? 0)장의 이용권이 차감됩니다"
    }

    @IBAction func useSoptTicketEvent() {
        useSpotTicket()
    }
    
    func recordVideo() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.controller.sourceType = .camera
            self.controller.mediaTypes = [kUTTypeMovie as String]
            self.controller.delegate = self
            
            self.show(self.controller, sender: nil)
        }
        else {
            print("Camera is not available")
        }
    }
}

extension UseSpotViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedVideo:URL = (info[UIImagePickerController.InfoKey.mediaURL] as? URL) {
            
            let compatible: Bool = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum((selectedVideo.path))
            // save
            if compatible {
                let selectorToCall = #selector(self.videoSaved(_:didFinishSavingWithError:context:))
                UISaveVideoAtPathToSavedPhotosAlbum((selectedVideo.path), self, selectorToCall, nil)
                print("saved!!!! \(String(describing: selectedVideo.path))")
                self.videoURL = selectedVideo
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func videoSaved(_ video: String, didFinishSavingWithError error: NSError!, context: UnsafeMutableRawPointer){
        if let theError = error {
            print("error saving the video = \(theError)")
        } else {
            DispatchQueue.main.async(execute: { () -> Void in
                print("videoData: ", video)
                let vc = PreViewViewController()
                vc.videoURL = self.videoURL
                vc.closeHandler = {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                self.showPopupView(vc: vc)
            })
        }
    }
}

extension UseSpotViewController {
    func useSpotTicket() {
        guard let count = spot.count, GlobalDatas.currentUser.ticketCount! >= count  else {
            AlertHandler.shared.showAlert(vc: self, message: "잔여 쿠폰수량이 부족합니다", okTitle: "확인")
            return
        }
        
        let parameters = [
            "spot_id": spot.id!,
            "unique_number": code
            ] as [String:Any]
        
        ServerUtil.shared.postSpotTicket(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                if let message = message {
                    AlertHandler.shared.showAlert(vc: self, message: message, okTitle: "확인")
                }
                return
            }
            self.recordVideo()
        }
    }
}
