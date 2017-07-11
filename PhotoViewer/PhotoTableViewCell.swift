//
//  PhotoTableViewCell.swift
//  PhotoViewer
//
//  Created by Abdul Faiz Mohideen Kannu on 14/12/2016.
//  Copyright © 2016 AbdulFaizMohideenKannu. All rights reserved.
//

import UIKit

protocol PhotoTableViewCellDelegate: class {
    func photoTapped(photoInfo: PhotoInfo?)
}

class PhotoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var flickrImage: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    
    let photoMgr = PhotoManager()
    //var photoSet = [PhotoInfo]()
    let detailView = DetailViewController()
    
    weak var delegate: PhotoTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    var flickr: PhotoInfo? {
        didSet {
            updateUI()
        }
    }
    
    func cellTapped() {
        if let delegate = delegate {
            delegate.photoTapped(photoInfo: flickr)
        }
    }
    
    func updateUI() {
        if let photo = flickr {
            imageName.text = photo.title
            //let img = photoSet[0]
            
            photoMgr.requestImage(urlString: photo.url_m, completion: {
                (data, success) in
                if success{
                    let queue = DispatchQueue.main
                    queue.async {
                        //self.image.image = UIImage(named: img.url_m)
                        if let img = data as? UIImage {
                            self.flickrImage.image = img
                        }
                        
                    }
                }
            })
        }

        
    }
    
      
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
