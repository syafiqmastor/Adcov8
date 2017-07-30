//
//  ProfileViewController.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/30/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit
import Fakery

enum UserHeaderTitle : String {
    case title = "title"
    case image = "image"
    case email = "Email"
    case logout = "Duration"
//    case description = "Details"
}

class ProfileViewController: UIViewController {
    @IBOutlet var headerView: UIView! {
        didSet {
            headerView.layer.shadowColor = UIColor.gray.cgColor
            headerView.layer.shadowOpacity = 0.5
            headerView.layer.shadowOffset = CGSize.zero
            headerView.layer.shadowRadius = 2
        }
    }

    @IBOutlet weak var tableView: UITableView!
    let faker = Faker()
    
    let detail = UserDetailDataModel(id: "",
                                     title: "Syafiq Mastor",
                                     image: "syafiq",
                                     email: "muhd.syafiqmastor@gmail.com")
    
    
    let sectionHeader : [UserHeaderTitle] = [.image,
                                         .email,
                                         .logout]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.lt_setBackgroundColor(.clear)
        registerCell(self.tableView, identifier: DescriptionTableViewCell.identifier)
        registerCell(self.tableView, identifier: ProfileTableViewCell.identifier)
        registerCell(self.tableView, identifier: ButtonTableViewCell.identifier)
        self.tableView.register(SectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension ProfileViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sectionHeader[indexPath.section] {
        case .image:
            return profileCellForRow(at: indexPath)
        case .logout:
            return logoutCellForRow(at: indexPath)
        default:
            return descriptionCellForRow(at: indexPath)
        }
    }
    
    func profileCellForRow(at indexPath : IndexPath) -> ProfileTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as! ProfileTableViewCell
        
        cell.cellImageView.image = UIImage(named: detail.image)
        cell.titleLabel.text = detail.title
        return cell
    }
    
    func descriptionCellForRow(at indexPath : IndexPath) -> DescriptionTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier) as! DescriptionTableViewCell
    
            cell.descriptionLabel.text = detail.email
        return cell
    }
    
    func logoutCellForRow(at indexPath : IndexPath) -> ButtonTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier) as! ButtonTableViewCell
        cell.logoutButton.addTarget(self, action: #selector(self.handleButton(sender:)), for: .touchUpInside)
        return cell
    }
    
    
    func handleButton(sender : UIButton) {
        let confirmAction = UIAlertAction(title: "Logout", style: .destructive) { (action) in
        
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardNavController") as! UINavigationController
            self.present(controller, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch sectionHeader[indexPath.section] {
        case .image:
            return 132
        default:
            self.tableView.estimatedRowHeight = 100
            return UITableViewAutomaticDimension
        }
        
        
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //        switch sectionHeader[section] {
    //        case .image, .title:
    //            return nil
    //        default :
    //            return sectionHeader[section].rawValue
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sectionHeader[section] {
        case .image:
            return nil
        case .logout:
            return UIView()
        default :
            let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.identifier) as! SectionHeaderView
            header.titleLabel.text = sectionHeader[section].rawValue
            return header
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sectionHeader[section] {
        case .image:
            return 0.01
        default :
            return 53
        }
        
    }
}
