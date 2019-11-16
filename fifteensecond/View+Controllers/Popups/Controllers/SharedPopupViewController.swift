//
//  SharedPopupViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/11/16.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Social

class SharedPopupViewController: UIViewController {
    
    var documentController: UIDocumentInteractionController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showKaKaoSharedEvent() {
        DispatchQueue.main.async {

            //Share To Instagram:
            let instagramURL = URL(string: "instagram://app")
            if UIApplication.shared.canOpenURL(instagramURL!) {

                let imageData = UIImage(named: "placeholderImage")!.jpegData(compressionQuality: 100)
                let writePath = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.igo")

                do {
                    try imageData?.write(to: URL(fileURLWithPath: writePath), options: .atomic)
                } catch {
                    print(error)
                }

                let fileURL = URL(fileURLWithPath: writePath)
                self.documentController = UIDocumentInteractionController(url: fileURL)
                self.documentController.delegate = self
                self.documentController.uti = "com.instagram.exlusivegram"

                if UIDevice.current.userInterfaceIdiom == .phone {
                    self.documentController.presentOpenInMenu(from: self.view.bounds, in: self.view, animated: true)
                } else {
                    self.documentController.presentOpenInMenu(from: .init(title: "test", style: .plain, target: nil, action: nil), animated: true)
                }
            } else {
                print(" Instagram is not installed ")
            }
        }
    }

    
    @IBAction func showMoreSharedEvent() {
        DispatchQueue.global(qos: .background).async {
            let urlData = NSData(data: UIImage(named: "placeholderImage")!.jpegData(compressionQuality: 100)!)
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let filePath="\(documentsPath)/15second.mov"
            DispatchQueue.main.async {
                urlData.write(toFile: filePath, atomically: true)
                
                //Hide activity indicator
                
                let activityVC = UIActivityViewController(activityItems: [NSURL(fileURLWithPath: filePath)], applicationActivities: nil)
                activityVC.excludedActivityTypes = [.addToReadingList, .assignToContact]
                activityVC.modalPresentationStyle = .fullScreen
                self.present(activityVC, animated: true, completion: nil)
            }
        }
    }

}

extension SharedPopupViewController: UIDocumentInteractionControllerDelegate {
    
}
