//
//  CasesViewController.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit
import Fakery

let cellArray : [DetailDataModel] = [
    DetailDataModel(id: "1",
                    title: "Citra",
                    image: "women1",
                    age : 25,
                    origin: "Indonesia",
                    sex: "Female",
                    duration: "2 months",
                    waiting: "7 months",
                    supportNeeded: "Relocation Cost, Reintegration Cost, Support with a small business to establish a sustainable livelihood.",
                    shortDescription : "Citra is a 25 year-old woman from a poor family in Indonesia. She lived a modest life until a series of health issues threw her life into financial disarray.",
                    description: "Citra is a 25 year-old woman from a poor family in Indonesia. She lived a modest life until a series of health issues threw her life into financial disarray. Hoping to overcome these challenges she decided to work in Hong Kong to pay back debt and put her family’s life back together. Instead she ended up becoming a victim of labour exploitation and sexual abuse. Having returned to Indonesia, she hopes to begin anew. She is planning to start a small business while trying to recover from her trauma.",
                    moneyNeed : "RM3000",
                    moneyHave : "RM0"),
    DetailDataModel(id: "2",
                    title: "Sarangerel",
                    image: "women2",
                    age : 17,
                    origin: "Mongolia",
                    sex: "Female",
                    duration: "5 months",
                    waiting: "18 months",
                    supportNeeded: "Medical Treatment, Reintegration Cost, Assistance to support her through her pregnancy and in raising her baby",
                    shortDescription : "Sarangerel grew up in the Umnugobi province, located in the south of Mongolia.",
                    description: "Sarangerel was only 16 when she was tricked into forced domestic work and sexual exploitation. As a result of the abuse, she got pregnant. She now hopes to start a new life and raise her baby in a safe and secure environment.",
                    moneyNeed : "RM2090",
                    moneyHave : "RM110"),
    DetailDataModel(id: "3",
                    title: "Tin Kyaw Aung",
                    image: "men1",
                    age : 28,
                    origin: "Myanmar",
                    sex: "Male",
                    duration: "2 years 1 month",
                    waiting: "26 months",
                    supportNeeded: "Relocation Cost, Reintegration Cost, Vocational Training and Trafficking Resifence, Fee for immigration processing to go back legally and settle in Indonesia",
                    shortDescription : "Tin Kyaw Aung once worked as a farmer in Myanmar until his friend, Myint Ta Thu, asked him to go to Thailand and work as fisherman with the promise of high salary.",
                    description: "28year old Tin Kyaw Aung was lured into working on a fishing boat. Following the advice of a friend, Ting Kyaw Aung followed the prospect of a high salary and good working conditions. His journey led him to Indonesia where he soon realized that neither promise would materialize.",
                    moneyNeed : "RM2170",
                    moneyHave : "RM1030")
    
]


enum DiscoverParent {
    case Cases
    case Organisation
}

protocol DiscoverDelegate {
    func didSelectRowAt(indexPath : IndexPath, from parent : TabTitle)
}




class CasesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let faker = Faker()
    var delegate : DiscoverDelegate!
    
//    let detail = DetailDataModel(id: "1",
//                                 title: "Some name",
//                                 image: "",
//                                 age : 25,
//                                 origin: "Indonesia",
//                                 sex: "Female",
//                                 duration: "2 months",
//                                 waiting: "7 months",
//                                 supportNeeded: "Bailing fees, Transport",
//                                 description: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell(self.tableView, identifier: CasesTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CasesViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let detail = cellArray[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CasesTableViewCell.identifier) as! CasesTableViewCell
        
        cell.shortSummaryDetail.text = detail.shortDescription
        cell.titleLabel.text = detail.title
        cell.progressLabel.text = detail.moneyHave
        cell.targetLabel.text = "out of " + detail.moneyNeed
        
        return cell
    }
}

extension CasesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.tableView.estimatedRowHeight = 100
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectRowAt(indexPath: indexPath, from: .cases)
    }
}
