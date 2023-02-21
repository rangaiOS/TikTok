//
//  TiktokCVC.swift
//  Tiktok
//
//  Created by Rishabh on 17/02/23.
//  Copyright © 2023 Ranga. All rights reserved.
//

import UIKit
import GSPlayer

class TiktokCVC: UICollectionViewCell {
    
    @IBOutlet weak var playerVw: VideoPlayerView!

    var videso:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewSetup()
    }
    
    
    func play(){
        playerVw.play(for: URL(string: videso)!)
        playerVw.isHidden = false
    }
    
    func pause(){
        playerVw.pause(reason: .hidden)
    }
    
    func viewSetup(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        playerVw.isUserInteractionEnabled = true
        playerVw.addGestureRecognizer(tap)
        print("player view \(playerVw.frame)")
    }
    
    
    @objc func viewTapped(){
        if playerVw.state == .playing{
            playerVw.pause(reason: .userInteraction)
        }else{
            playerVw.resume()
        }
        
    }
}
