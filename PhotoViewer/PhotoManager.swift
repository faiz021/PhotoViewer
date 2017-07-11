//
//  PhotoManager.swift
//  PhotoViewer
//
//  Created by Abdul Faiz Mohideen Kannu on 25/11/2016.
//  Copyright © 2016 AbdulFaizMohideenKannu. All rights reserved.
//

import UIKit

class PhotoManager{

    //Dataset
    var photoSet = [PhotoInfo]()
    var myTableView = UITableView()
    
    //Call back closure definition
    typealias PhotoData = (Any?, Bool)->()
    
    //Will be called by the viewcontroller
    //The completion parameter is the closure that will be used to notify the ViewController
    func requestRecentPhotos(completion: @escaping PhotoData){
        let apiKey = "64a2df6ae868a3d3da1f7995a6ec7671"
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key="+apiKey+"&format=json&nojsoncallback=1&extras=url_m&per_page=10")
       
        let dataTask = URLSession.shared.dataTask(with: url!){
        (data, response, error)in self.didFetchRecentPhotos(data: data, response: response!, downloadError: error, completion: completion)
        }
//        myTableView.reloadData()
        dataTask.resume()
    }
    
    //Call back for the URLsession
    private func didFetchRecentPhotos(data:Data?, response: URLResponse, downloadError: Error?, completion:@escaping PhotoData){
        
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
            guard let photos = jsonData["photos"] as? [String:Any] else {
                completion(nil,false)
                return
            }
            guard let photoList = photos["photo"] as? [Any] else {
                completion(nil,false)
                return
            }
            
            for photoInfo in photoList {
                let photo = PhotoInfo()
                
                guard let info = photoInfo as? [String:Any] else {
                    completion(nil, false)
                    return
                }
                if let id = info["id"] as? String {
                    photo.id = id
                }
                if let title = info["title"] as? String {
                    photo.title = title
                }
                if let um = info["url_m"] as? String  {
                    photo.url_m = um
                }
                photoSet.append(photo)
                
            }
            
            completion(photoSet, true)
            
            
        } catch let error {
            print("Decoding error \(error)")
        }

        
    }
    
    
    func requestImage(urlString: String, completion: @escaping PhotoData){
       // var images = [UIImage()]
        
        let url = URL(string:urlString)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!){
        data, response, error in
            
            if let _ = error {
                completion(nil, false)
                return
            }
            let image = UIImage(data: data!)
           // image.append(image!)
           completion(image, true)
        }
        task.resume()        
    }
    
    
    
    

}
