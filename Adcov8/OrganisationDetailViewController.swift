//
//  OrganisationDetailViewController.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit
import Fakery

enum OrgHeaderTitle : String {
    case title = "title"
    case location = "Location"
    case image = "image"
    case description = "Details"
    case cases = "Cases worked on"
}

class OrganisationDetailViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    let faker = Faker()
    let sectionHeader : [OrgHeaderTitle] = [.image,
                                         .title,
                                         .location,
                                         .description,
                                         .cases]
    
    
    let victimdetail = cellArray
    
    var detail = OrgDetailDataModel(id: "", title: "", image: "", location: "", cases: [], description: "")
    
    var bottomBarVC  = BottomViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        detail = OrgDetailDataModel(id: "1",
                                    title: "6 Degree Org",
                                    image: "sixDegree",
                                    location: "International Organization for Migration, Regional Office for Asia and the Pacific, 18th Floor, Rajanakarn Building 3 South Sathorn Road, Bangkok, 10120, Thailand",
                                    cases: victimdetail,
                                    description: "IOM Case Officers determine a funding goal based on the survivor’s needs. This may cover costs directly associated with his or her immediate accommodation in a place of safety, medical or legal assistance, the return journey home, education or skills development, job placement, or help with establishing a small business. With permission of the survivor, IOM Case Officers then make the case available on 6degree.org.")
        
        
        
        registerCell(self.tableView, identifier: CasesTableViewCell.identifier)
        registerCell(self.tableView, identifier: TitleTableViewCell.identifier)
        registerCell(self.tableView, identifier: ImageTableViewCell.identifier)
        registerCell(self.tableView, identifier: DescriptionTableViewCell.identifier)
        self.tableView.register(SectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)
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

extension OrganisationDetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionHeader[section] {
        case .cases:
            return detail.cases.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sectionHeader[indexPath.section] {
        case .image:
            return imageCellForRow(at: indexPath)
        case .title:
            return titleCellForRow(at: indexPath)
        case .cases:
            return casesCellForRow(at: indexPath)
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
    
    func casesCellForRow(at indexPath : IndexPath) -> CasesTableViewCell {
        
        let detail = cellArray[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CasesTableViewCell.identifier) as! CasesTableViewCell
        
        cell.shortSummaryDetail.text = detail.shortDescription
        cell.titleLabel.text = detail.title
        cell.progressLabel.text = detail.moneyHave
        cell.targetLabel.text = "out of " + detail.moneyNeed
        
        return cell
    }
    
    func descriptionCellForRow(at indexPath : IndexPath) -> DescriptionTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier) as! DescriptionTableViewCell
        switch sectionHeader[indexPath.section] {
        case .location:
            cell.descriptionLabel.text = String(describing: detail.location)
        case .description:
            cell.descriptionLabel.text = String(describing: faker.lorem.paragraphs())
        default:
            break
        }
        return cell
    }
}

extension OrganisationDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sectionHeader[indexPath.section] {
        case .cases:
            
            let det = detail.cases[indexPath.row]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            vc.detail = det
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
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
