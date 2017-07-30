//
//  DetailViewController.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit
import Fakery
import Braintree
import BraintreeDropIn





enum HeaderTitle : String {
    case title = "title"
//    case age = "Age"
    case image = "image"
    case origin = "Origin"
//    case sex = "Sex"
    case duration = "Duration"
    case waiting = "Waiting to go home"
    case supportNeeded = "Support Needed"
    case description = "Details"
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let faker = Faker()
    
    var detail : DetailDataModel!
    
    
    let sectionHeader : [HeaderTitle] = [.image,
                                         .title,
//                                         .age,
                                         .origin,
//                                         .sex,
                                         .duration,
                                         .waiting,
                                         .supportNeeded,
                                         .description]
    
    var bottomBarVC  = BottomViewController()
    let clientToken = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJiYjI1ZjRjNTJmZWRmNTg1YjdmYjkxYTIyYjk1YTRiNWJmNDUyNjE3OTBmMjkxMDU4ZmU0MTk2NWI5YTEzNjdjfGNyZWF0ZWRfYXQ9MjAxNy0wNy0yOVQxNzowODo1OS4zMzE0MzUzMjIrMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzM0OHBrOWNnZjNiZ3l3MmIvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0="
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        registerCell(self.tableView, identifier: TitleTableViewCell.identifier)
        registerCell(self.tableView, identifier: ImageTableViewCell.identifier)
        registerCell(self.tableView, identifier: DescriptionTableViewCell.identifier)
        registerCell(self.tableView, identifier: LeftRightTableViewCell.identifier)
        self.tableView.register(SectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)
        self.tableView.register(NewSectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: NewSectionHeaderView.identifier)
        
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
        
        self.addBottomBar()
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
//        self.navigationController?.navigationBar.lt_setBackgroundColor(.clear)
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image:  UIImage(named: "back.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.handleBackButtonItem(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    func addBottomBar() {
        bottomBarVC = BottomViewController(nibName: "BottomViewController", bundle: nil)
        bottomBarVC.delegate = self
        
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
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                result.paymentOptionType = .payPal
                result.paymentOptionType = .venmo
                let selectedPaymentMethod = result.paymentMethod
                //                print("nonce : \(selectedPaymentMethod?.nonce)")
            
                
                //                self.postNonceToServer(paymentMethodNonce: (selectedPaymentMethod?.nonce)!)
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    func handleBackButtonItem(_ sender : UIBarButtonItem) {
//        tableViewBottomConstraint.constant
//            = 0
        bottomBarVC.view.removeFromSuperview()
        bottomBarVC.removeFromParentViewController()
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController : UITableViewDataSource {
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
        case .origin:
            return leftRightCellForRow(at: indexPath)
        case .duration, .waiting,.supportNeeded,.description:
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
        cell.titleLabel.text = detail.title + "," + String(describing: detail.age)
        return cell
    }
    
    func leftRightCellForRow(at indexPath : IndexPath) -> LeftRightTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: LeftRightTableViewCell.identifier) as! LeftRightTableViewCell
        cell.leftLabel.text = detail.origin
        cell.rightLabel.text = detail.sex
        return cell
    }
    
    func descriptionCellForRow(at indexPath : IndexPath) -> DescriptionTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier) as! DescriptionTableViewCell
        switch sectionHeader[indexPath.section] {
        case .origin:
            cell.descriptionLabel.text = String(describing: detail.origin)
        case .duration:
             cell.descriptionLabel.text = String(describing: detail.duration)
        case .waiting:
            cell.descriptionLabel.text = String(describing: detail.waiting)
        case .supportNeeded:
            cell.descriptionLabel.text = String(describing: detail.supportNeeded)
        case .description:
            cell.descriptionLabel.text = String(describing: detail.description)
        default:
            break
        }
        return cell
    }
}

extension DetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch sectionHeader[indexPath.section] {
        case .image:
            return 200
        default:
            self.tableView.estimatedRowHeight = 100
            return UITableViewAutomaticDimension
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sectionHeader[section] {
        case .image, .title:
            return nil
            
        case .origin:
            let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: NewSectionHeaderView.identifier) as! NewSectionHeaderView
            header.leftLabel.text = "Origin"
            header.rightLabel.text = "Sex"
            return header
        default :
            let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.identifier) as! SectionHeaderView
            header.titleLabel.text = sectionHeader[section].rawValue
            return header
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sectionHeader[section] {
        case .image, .title:
            return 1.0
        default :
            return 53
        }

    }
}

extension DetailViewController : BottomDelegate {
    func didSelectDonateButton(_ sender: UIButton) {
        showDropIn(clientTokenOrTokenizationKey: clientToken
        )
    }
}
