//
//  OrganisationViewController.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit
import Fakery

let orgArray : [OrgDetailDataModel] = [
    OrgDetailDataModel(id: "1",
                       title: "6 Degree Org",
                       image: "sixDegree",
                       location: "International Organization for Migration, Regional Office for Asia and the Pacific, 18th Floor, Rajanakarn Building 3 South Sathorn Road, Bangkok, 10120, Thailand",
                       cases: cellArray,
                       description: "IOM Case Officers determine a funding goal based on the survivor’s needs. This may cover costs directly associated with his or her immediate accommodation in a place of safety, medical or legal assistance, the return journey home, education or skills development, job placement, or help with establishing a small business. With permission of the survivor, IOM Case Officers then make the case available on 6degree.org.")
]

class OrganisationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let faker = Faker()
    var delegate : DiscoverDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell(self.tableView, identifier: CasesTableViewCell.identifier)
        registerCell(self.tableView, identifier: OrgTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension OrganisationViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: OrgTableViewCell.identifier) as! OrgTableViewCell
        
        
        let organisation = orgArray[indexPath.row]
        cell.titleLabel.text = organisation.title
        cell.subtitleLabel.text = organisation.description
        cell.cellImageView.image = UIImage(named: "Women-in-Fields")
        
        return cell
    }
}

extension OrganisationViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.tableView.estimatedRowHeight = 100
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectRowAt(indexPath: indexPath, from: .organisations)
    }
}
