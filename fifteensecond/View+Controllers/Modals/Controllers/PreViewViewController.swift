//
//  PreViewViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 09/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PreViewViewController: UIViewController {
    
    var videoURL: URL!
    
    var closeHandler: (()->())!
    
//    var player: AVPlayer!

    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var palyBtn: UIButton!
    @IBOutlet weak var preViewImaegView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preViewImaegView.image = videoSnapshot(filePathLocal: videoURL.path)
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.modalPresentationStyle = .fullScreen
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    
    override func closeView() {
        self.dismiss(animated: true) {
            self.closeHandler()
        }
    }
    
    @IBAction func shareVideo() {
        DispatchQueue.global(qos: .background).async {
            if let urlData = NSData(contentsOf: self.videoURL){
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
    
    func videoSnapshot(filePathLocal: String) -> UIImage? {
        
        let vidURL = URL(fileURLWithPath:filePathLocal)
        let asset = AVURLAsset(url: vidURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
    }

}
