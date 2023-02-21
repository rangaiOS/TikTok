//
//  TiktokVC.swift
//  Tiktok
//
//  Created by Rishabh on 17/02/23.
//  Copyright © 2023 Ranga. All rights reserved.
//

import UIKit

class TiktokVC: UIViewController {
    
    @IBOutlet weak var colvw: UICollectionView!

    var videoModelArr = [VideoJSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colvw.register(UINib(nibName: "TiktokColCVC", bundle: nil), forCellWithReuseIdentifier: "TiktokColCVC")
        
        fetchingJSON()
    }
    
    
    func fetchingJSON(){
        guard let fileLocation = Bundle.main.url(forResource: "videos", withExtension: "json") else {return}
        do{
            let data = try Data(contentsOf: fileLocation)
            let json = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
            print(json)
            let decoder = try JSONDecoder().decode([VideoJSON].self, from: data)
            print(decoder)
            videoModelArr = decoder
        }catch{
            print(error.localizedDescription)
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        colvw.isPagingEnabled = true
        colvw.setCollectionViewLayout(layout, animated: true)
        colvw.contentInsetAdjustmentBehavior = .never;
        colvw.automaticallyAdjustsScrollIndicatorInsets = false

    }
    
}


extension TiktokVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoModelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TiktokColCVC", for: indexPath) as! TiktokColCVC
        cell.videso = videoModelArr[indexPath.row].videoURL
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(btnLikeAction), for: .touchUpInside)
        if videoModelArr[indexPath.row].isLive! == true{
            cell.likekImg.image = UIImage(systemName: "heart.fill")
            cell.btnLike.isSelected = true
        }else{
            print(videoModelArr[indexPath.row].id!,videoModelArr[indexPath.row].isLive!)
            cell.likekImg.image = UIImage(systemName: "heart")
            cell.btnLike.isSelected = false
        }
        cell.lblID.text = videoModelArr[indexPath.row].id
        cell.lblTitle.text = videoModelArr[indexPath.row].title

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
   

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? TiktokColCVC{
            cell.play()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? TiktokColCVC{
            cell.pause()
        }
    }
    
    @objc func btnLikeAction(sender:UIButton){
        sender.isSelected = !sender.isSelected
        guard let cell = sender.superview?.superview as? TiktokColCVC else {
            return
        }
        
        if sender.isSelected{
            videoModelArr[sender.tag].isLive = true
        UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseIn) {
                cell.likekImg.image = UIImage(systemName: "heart.fill")
                cell.likekImg.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            } completion : { finished in
                UIView.animate(withDuration: 0.3){
                    cell.likekImg.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            }
        }else{
            videoModelArr[sender.tag].isLive = false
            UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseIn) {
                cell.likekImg.image = UIImage(systemName: "heart")
                cell.likekImg.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            } completion : { finished in
                UIView.animate(withDuration: 0.3){
                    cell.likekImg.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            }
        }
    }
    
   
}




