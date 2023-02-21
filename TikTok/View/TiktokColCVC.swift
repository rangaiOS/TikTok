//
//  TiktokColCVC.swift
//  Tiktok
//
//  Created by Rishabh on 17/02/23.
//  Copyright © 2023 Ranga. All rights reserved.
//

import UIKit
import GSPlayer

class TiktokColCVC: UICollectionViewCell {
    
    @IBOutlet weak var playerVw: VideoPlayerView!
    @IBOutlet weak var playImg: UIImageView!
    @IBOutlet weak var diskImg: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var likekImg: UIImageView!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    var videso:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewSetup()
    }
    
    
    func play(){
        playImg.isHidden = true
        playerVw.play(for: URL(string: videso)!)
        playerVw.isHidden = false
        diskImg.rotate(duration: 3)

    }
    
    func pause(){
       // playImg.isHidden = false
        playerVw.pause(reason: .hidden)
        diskImg.stopRotating()
    }
    
    func viewSetup(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        playerVw.isUserInteractionEnabled = true
        playerVw.addGestureRecognizer(tap)
        print("player view \(playerVw.frame)")
    }
    
    
    @objc func viewTapped(){
        if playerVw.state == .playing{
            playImg.isHidden = false
            playerVw.pause(reason: .userInteraction)
            diskImg.stopRotating()
        }else{
            playImg.isHidden = true
            playerVw.resume()
            diskImg.rotate(duration: 3)

        }
        
    }
}


extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"

    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity

            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }

    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
