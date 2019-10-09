//
//  UseSpotTicketViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 06/10/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import MobileCoreServices

class UseSpotTicketViewController: UIViewController {
    
    var spot: SpotDatas!
    
    var controller = UIImagePickerController()
    let videoFileName = "/video.mp4"
    
    var videoURL: URL!
    
    @IBOutlet weak var needTicketCountLabel: UILabel!
    @IBOutlet weak var hasTicketCountLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        needTicketCountLabel.text = "이용권 \(spot.count ?? 0)장 필요"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "이용권 사용하기"
        getUserInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func showBuyTicketView() {
        let vc = BuySpotTicketViewController()
        show(vc, sender: nil)
    }
    
    @IBAction func useSpotEvent() {
        if let ticketCount = GlobalDatas.currentUser.ticketCount, let needCount = spot.count, ticketCount < needCount {
            AlertHandler.shared.showAlert(vc: self, message: "티켓 수량이 부족합니다.", okTitle: "확인")
            return
        }
        let vc = SpotUsePopupViewController()
//        vc.useSpotTicket = ticket
        vc.closeHandler = {
            self.useSpotTicket()
        }
        self.showPopupView(vc: vc)
//        AlertHandler.shared.showAlert(vc: self, message: "Sopt을\n이용하시겠습니까?", okTitle: "확인", cancelTitle: "취소", okHandler: { (_) in
//
//        })
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

extension UseSpotTicketViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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

extension UseSpotTicketViewController {
    
    func getUserInfo() {
        let parameters = [
            "os": "iOS",
            "device_token": GlobalDatas.deviceToken
        ] as [String:Any]
        
        ServerUtil.shared.getInfo(self, parameters: parameters) { (success, dict, message) in
            guard success, let isAttend = dict?["today_attendance"] as? Bool,
                let user = dict?["user"] as? NSDictionary else { return }
            
            GlobalDatas.currentUser = UserData(user, isAttend: isAttend)
            
            self.hasTicketCountLabel.text = "보유 이용권 매수 \(GlobalDatas.currentUser.ticketCount ?? 0)장"
        }
    }
    
    func useSpotTicket() {
        let parameters = [
            "spot_id": spot.id!
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
