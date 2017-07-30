//
//  TrackViewController.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit
import Fakery

class TrackViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView! {
        didSet {
            headerView.layer.shadowColor = UIColor.gray.cgColor
            headerView.layer.shadowOpacity = 0.5
            headerView.layer.shadowOffset = CGSize.zero
            headerView.layer.shadowRadius = 2
        }
    }
    
    let faker = Faker()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell(self.tableView, identifier: TrackTableViewCell.identifier)
        self.navigationController?.navigationBar.lt_setBackgroundColor(.clear)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TrackViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier) as! TrackTableViewCell
        
        cell.cellImageView.image = UIImage(named: "Women-in-Fields")
        cell.titleLabel.text = "Sarangel"
        cell.dateLabel.text = "Updated 19 July 2017"
        
        return cell
    }
}

extension TrackViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.tableView.estimatedRowHeight = 132
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TrackDetailViewController") as! TrackDetailViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


