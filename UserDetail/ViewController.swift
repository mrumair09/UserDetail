//
//  ViewController.swift
//  UserDetail
//
//  Created by Umair Yousaf on 09/11/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK:- Properties
    
    var array: [ResponseModel] = []
    var filteredData: [ResponseModel] = []
    var recordsArray :[ResponseModel] = []
    var filter :[ResponseModel] = []
    var data: [String]?
    let viewWidth = UIScreen.main.bounds.width
    let viewHeight = UIScreen.main.bounds.height
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userSearchbar: UISearchBar!
    var limit = 17
    
    let totalEnteries = 100
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        activityIndicatorView.frame = CGRect(x: viewWidth/2 - 25  , y: viewHeight/2 - 25 , width: 50 , height: 50)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        loadDesign()
        userTableView.delegate = self
        userTableView.dataSource = self
        userSearchbar.delegate = self
        userTableView.register(UINib(nibName: "UserTableCell", bundle: nil), forCellReuseIdentifier: "UserTableCell")
        getUserData()
        
    }

    //MARK:- TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as! UserTableCell
        
        cell.userNameLabel.text = self.filter[indexPath.row].login
        cell.userDetailLabel.text = self.filter[indexPath.row].nodeID
        let urlString = self.filter[indexPath.row].avatarURL
        let output = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        cell.imgurl = output
        cell.downloadpic(url: output ?? "")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserDetailViewController()
        vc.modalPresentationStyle = .fullScreen
       
        DispatchQueue.main.async {
            
            vc.userNameLabel.text = self.filter[indexPath.row].login
            vc.nameLabel.text = self.filter[indexPath.row].login
            
//            let urlString = self.filter[indexPath.row].organizationsURL
//            let output = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            vc.getOrgnizationData(url: output ?? "")
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
       // print(recordsArray.count)
        
        if userSearchbar.inputAccessoryView == nil {
            
            DispatchQueue.main.async { [self] in
                if self.filter.count - 1 == indexPath.row {
                    if self.filter.count < self.array.count {
                        // we need to bring more records as there are some pending records available
                        var index = self.filter.count
                        self.limit = index + 5
                        while index < limit && index < array.count {
                            
                            filter.append(array[index])
                            index = index + 1
                        }
                        
                            self.userTableView.reloadData()
                        }
                    }
                }
            
        } else {
        
            return
        }
        }
    //MARK:- SearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.filter = searchText.isEmpty ? recordsArray : recordsArray.filter {$0.login?.range(of: searchText , options: .caseInsensitive) != nil}
        
//        self.filteredData = searchText.isEmpty ? array : array.filter {$0.login?.range(of: searchText , options: .caseInsensitive) != nil}
//
        DispatchQueue.main.async {
            self.userTableView.reloadData()
        }
    }
    
    //MARK:- Other
    
    func loadDesign () {
        userSearchbar.autocapitalizationType = .none
        userSearchbar.layer.cornerRadius = 16
    }
    
    func getUserData(){
        
        let service = Service()
        service.getUserResponse { [self]  list in
            self.array = list
           
            
            DispatchQueue.main.async {
                
                var index = 0
                while index < limit {
                    recordsArray.append(array[index])
                    filter = recordsArray
                    index = index + 1
                }
                self.userTableView.reloadData()
                activityIndicatorView.stopAnimating()
            
            }
            
        }
    }
    
}


