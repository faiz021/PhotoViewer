//
//  ViewController.swift
//  PhotoViewer
//
//  Created by Abdul Faiz Mohideen Kannu on 25/11/2016.
//  Copyright © 2016 AbdulFaizMohideenKannu. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {
    
//    var photoSet = [PhotoInfo]()
//    var currentPhoto = 0
    
    
    let photoMgr = PhotoManager()
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
    
    @IBAction func shareSheet(_ sender: UIButton) {
        
        let message = "Guys, I'm testing my app so ignore this photo!"
//        let image = UIImage(named: "image")!
        
        let image = photo.image!
        
        let sheet = UIActivityViewController(
            activityItems: [message, image],
            applicationActivities: nil)
        self.present(sheet, animated: true, completion: nil)
    }

    
    var photoIndex: Int?
    var photoInfos = [PhotoInfo]()
    
    func showPhoto(pos: Int){
        guard pos >= 0 && pos < photoInfos.count else { return }
        
        let info = photoInfos[pos]
        self.imageTitle.text = info.title
        photoMgr.requestImage(urlString: info.url_m, completion: {
            (data, success) in
            if success{
                let queue = DispatchQueue.main
                queue.async {
                    if let img = data as? UIImage {
                        self.photo.image = img

                    }
                    
                }
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = photoIndex {
            showPhoto(pos: index)
        }
//        photoMgr.requestRecentPhotos(){
//            (data, success) in
//            if success{
//                self.photoSet = data as! [PhotoInfo]
//                
//                self.showPhoto(pos: 0)
//                
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var image: UIImageView!
    
    @IBAction func next(_ sender: UIButton) {
        guard let index = photoIndex else { return }
        
        if index >= 0 && index < photoInfos.count - 1 {
            photoIndex! += 1
            showPhoto(pos: photoIndex!)
        }
    }
    
    @IBAction func previous(_ sender: UIButton) {
        guard let index = photoIndex else { return }
        
        if index > 1 && index < photoInfos.count {
            photoIndex! -= 1
            showPhoto(pos: photoIndex!)
        }
    }
    
   

}

