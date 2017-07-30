//
//  TrackDetailViewController.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit
import Fakery

enum TrackHeaderTitle : String {
    case title = "title"
    case image = "image"
    case description = "Details"
}


class TrackDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let faker = Faker()
    let sectionHeader : [TrackHeaderTitle] = [.image,
                                            .title,
                                            .description]
    
    
    
    var detail = TrackDetailDataModel(id: "", title: "", image: "", description: "")
    
    var bottomBarVC  = BottomViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        detail = TrackDetailDataModel(id: "Sarangerel",
                                    title: "Sarangerel works at her own a farm",
                                    image: "Women-in-Fields",
                                    description: faker.lorem.paragraphs() + faker.lorem.paragraphs())
        
        
        registerCell(self.tableView, identifier: TitleTableViewCell.identifier)
        registerCell(self.tableView, identifier: ImageTableViewCell.identifier)
        registerCell(self.tableView, identifier: DescriptionTableViewCell.identifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
        self.tableView.isHidden = false
        
//        self.addBottomBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.bottomBarVC.view.removeFromSuperview()
        self.bottomBarVC.removeFromParentViewController()
        //        navigationController?.navigationBar.lt_reset()
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func configureNavigationBar() {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image:  UIImage(named: "back.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.handleBackButtonItem(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    func addBottomBar() {
        bottomBarVC = BottomViewController(nibName: "BottomViewController", bundle: nil)
        //        bottomBarVC.bottomBarType = self.bottomBarType
        //        bottomBarVC.delegate = self
        
        let screenSize = UIScreen.main.bounds.size
        var bottomBarFrameRect = bottomBarVC.view.frame
        bottomBarFrameRect.size.width = screenSize.width
        bottomBarFrameRect.size.height = 80
        bottomBarFrameRect.origin.x = 0
        bottomBarFrameRect.origin.y = screenSize.height
        bottomBarVC.view.frame = bottomBarFrameRect
        self.navigationController?.addChildViewController(bottomBarVC)
        self.navigationController?.view.addSubview(bottomBarVC.view)
        bottomBarFrameRect.origin.y = screenSize.height - bottomBarFrameRect.size.height
        
        UIView.animate(withDuration: 0.5) {
            //            self.tableViewBottomConstraint.constant = 90
            self.bottomBarVC.view.frame = bottomBarFrameRect
        }
    }
    
    func handleBackButtonItem(_ sender : UIBarButtonItem) {
        //        tableViewBottomConstraint.constant
        //            = 0
        bottomBarVC.view.removeFromSuperview()
        bottomBarVC.removeFromParentViewController()
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension TrackDetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sectionHeader[indexPath.section] {
        case .image:
            return imageCellForRow(at: indexPath)
        case .title:
            return titleCellForRow(at: indexPath)
        default:
            return descriptionCellForRow(at: indexPath)
        }
    }
    
    func imageCellForRow(at indexPath : IndexPath) -> ImageTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier) as! ImageTableViewCell
        
        cell.cellImageView.image = UIImage(named: detail.image)
        return cell
    }
    
    func titleCellForRow(at indexPath : IndexPath) -> TitleTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier) as! TitleTableViewCell
        cell.titleLabel.text = detail.title
        return cell
    }
    
    func descriptionCellForRow(at indexPath : IndexPath) -> DescriptionTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier) as! DescriptionTableViewCell
    
            cell.descriptionLabel.text = String(describing: faker.lorem.paragraphs())

        return cell
    }
}

extension TrackDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch sectionHeader[indexPath.section] {
        case .image:
            return 200
        default:
            self.tableView.estimatedRowHeight = 100
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
        
    }
}
