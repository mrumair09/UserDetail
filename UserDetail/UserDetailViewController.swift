//
//  UserDetailViewController.swift
//  UserDetail
//
//  Created by Umair Yousaf on 09/11/2021.
//

import UIKit

class UserDetailViewController: UIViewController {

    var orgnization : String?
    var orgnizationArray : [OrgnizationResponseModel]?
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var notesView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.borderWidth = 1.5
        saveButton.layer.borderColor = UIColor.lightGray.cgColor
        detailView.layer.borderWidth = 1.5
        detailView.layer.borderColor = UIColor.lightGray.cgColor
        notesView.layer.borderWidth = 1.5
        notesView.layer.borderColor = UIColor.lightGray.cgColor
       
    }
    
    func configure(userDetail:ResponseModel?){
    
        DispatchQueue.main.async {
            self.userNameLabel.text = userDetail?.login
            self.nameLabel.text = userDetail?.login
           // self.orgnization = userDetail?.organizationsURL
            
        }
        
    }

    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func getOrgnizationData(url: String){
//
//        let service = Service()
//        service.getOrgnizationResponse(link: url ) { [self]  list in
//            self.orgnizationArray = list
//            DispatchQueue.main.async {
//                self.companyLabel.text = self.orgnizationArray?[0].login
//            }
//
//        }
//    }

}

