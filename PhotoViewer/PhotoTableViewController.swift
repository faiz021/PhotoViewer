//
//  PhotoTableViewController.swift
//  PhotoViewer
//
//  Created by Abdul Faiz Mohideen Kannu on 14/12/2016.
//  Copyright © 2016 AbdulFaizMohideenKannu. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    
    var photos = [PhotoInfo]()
    let photoMgr = PhotoManager()
    let detailView = DetailViewController()
    var photoInfo: PhotoInfo?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startActivity()
        
        photoMgr.requestRecentPhotos(){
            (data, success) in
            if success{
                self.photos = data as! [PhotoInfo]
                self.tableView.reloadData()
                //self.detailView.showPhoto(pos: 0)
                
                self.stopActivity()
            }
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func startActivity(){
        self.activityIndicator.startAnimating()
    }
    func stopActivity(){
        self.activityIndicator.stopAnimating()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            if let detail = segue.destination as? DetailViewController {
                detail.photoInfos = self.photos
                detail.photoIndex = photoInfo?.index
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoTableCell", for: indexPath) as! PhotoTableViewCell
        cell.flickr = photos[indexPath.row]
        cell.flickr?.index = indexPath.row
        cell.delegate = self
        
        return cell
    }   
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PhotoTableViewController : PhotoTableViewCellDelegate {
    
    func photoTapped(photoInfo: PhotoInfo?) {
        self.photoInfo = photoInfo
        self.performSegue(withIdentifier: "ToDetail", sender: self)
    }
}
