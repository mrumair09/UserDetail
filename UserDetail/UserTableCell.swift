//
//  TableViewCell.swift
//  UserDetail
//
//  Created by Umair Yousaf on 09/11/2021.
//

import UIKit

class UserTableCell: UITableViewCell {

    var imgurl : String?
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDetailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator.frame = CGRect(x: 0  , y: 0 , width: 45  , height: 45)
        self.addSubview(activityIndicator)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    func downloadpic(url: String) {
        self.activityIndicator.startAnimating()
        
        if let catPictureURL = URL(string: url){

        let session = URLSession(configuration: .default)

        let downloadPicTask = session.dataTask(with: catPictureURL ) { (data, response, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {

                if let res = response as? HTTPURLResponse {
                    //print("Downloaded picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        DispatchQueue.main.async {
                            self.userImage.image = UIImage(data: imageData)
                        self.activityIndicator.stopAnimating()
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
        } }
}
