//
//  HasSpotTicketListViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 09/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import MobileCoreServices

class HasSpotTicketListViewController: UIViewController {
    
    var spot: SpotDatas!
    
    var controller = UIImagePickerController()
    let videoFileName = "/video.mp4"
    
    var videoURL: URL!
    
    var useableTicketList = [SpotTicketUseInfoDatas]() {
        didSet {
            
            hasTicketCountLabel.text = "보유 이용권 \(useableTicketList.count)장"
            if useableTicketList.isEmpty {
                hasTicketCountLabel.isHidden = false
            }
            else {
                hasTicketCountLabel.isHidden = true
            }
            
            hasSpotTicketTableView.reloadData()
        }
    }
    
    @IBOutlet weak var hasSpotTicketTableView: UITableView!
    @IBOutlet weak var emptyListLabel: UILabel!
    @IBOutlet weak var hasTicketCountLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hasSpotTicketTableView.register(UINib(nibName: "HasSpotTicketTableViewCell", bundle: nil), forCellReuseIdentifier: "spotCell")
        hasSpotTicketTableView.delegate = self
        hasSpotTicketTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "이용권 사용하기"
        getHasSpotTicketList()
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }

    
    @IBAction func buySoptTicketEvent() {
        let vc = SpotTicketListViewController()
        show(vc, sender: nil)
    }
}


extension HasSpotTicketListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useableTicketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spotCell", for: indexPath) as! HasSpotTicketTableViewCell
        cell.initView(useableTicketList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard spot != nil else { return }
//
//        let ticket = useableTicketList[indexPath.item]
//
//        AlertHandler.shared.showAlert(vc: self, message: "\(ticket.ticketKind?.name ?? "")을\n사용하시겠습니까?", okTitle: "확인", cancelTitle: "취소", okHandler: { (_) in
//            let vc = SpotUsePopupViewController()
//            vc.useSpotTicket = ticket
//            vc.closeHandler = {
//                self.useSpotTicket(ticket.id)
//            }
//            self.showPopupView(vc: vc)
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



extension HasSpotTicketListViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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

extension HasSpotTicketListViewController {
    func getHasSpotTicketList() {
        ServerUtil.shared.getSpotTicket(self) { (success, dict, message) in
            guard success, let array = dict?["spot_ticket"] as? NSArray else {
                return
            }
            
            self.useableTicketList = array.compactMap { SpotTicketUseInfoDatas($0 as! NSDictionary) }
        }
    }
    
    func useSpotTicket(_ useSpotTicketId: Int) {
        let parameters = [
            "spot_ticket_id": useSpotTicketId,
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
