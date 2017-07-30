//
//  DiscoverViewController.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit

enum TabTitle : String {
    case cases = "Cases"
    case organisations = "Organisations"
    
}


class DiscoverViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!{
        didSet {
            headerView.layer.shadowColor = UIColor.gray.cgColor
            headerView.layer.shadowOpacity = 0.5
            headerView.layer.shadowOffset = CGSize.zero
            headerView.layer.shadowRadius = 2
        }
    }
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!

    var pageMenu : CAPSPageMenu?
    let tabTitle : [TabTitle] = [.cases, .organisations]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.lt_setBackgroundColor(.clear)
        
        configurePageMenu()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func configurePageMenu() {
        var controllerArray : [UIViewController] = []
        
        let caseVC = self.storyboard?.instantiateViewController(withIdentifier: "CasesViewController") as! CasesViewController
        caseVC.delegate = self
        
        let orgVC = self.storyboard?.instantiateViewController(withIdentifier: "OrganisationViewController") as! OrganisationViewController
        orgVC.delegate = self
        
        let viewControllers = [caseVC, orgVC]
        
        for i in 0..<viewControllers.count {
            let controller = viewControllers[i]
            
            controller.title = tabTitle[i].rawValue
            controllerArray.append(controller)
        }
        
//        UIColor(red: 29.0 / 255.0, green: 29.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
        let pageMenuParameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor(hexString: "F6F7F7")),
            .viewBackgroundColor(UIColor.blue),
            .selectionIndicatorColor(UIColor(hexString: "7FB9F8")),
            .selectedMenuItemLabelColor(UIColor(hexString: "7FB9F8")),
            .unselectedMenuItemLabelColor(UIColor(hexString : "C9C8CC")),
            .menuItemSeparatorWidth(0.5),
            .menuMargin(40.0),
            .menuItemMargin(5.0),
            .centerMenuItems(true),
            .addBottomMenuHairline(false),
            //            .menuItemFont(UIFont(name: "Avenir-Next", size: 14)!),
            .menuHeight(50.0),
            .titleTextSizeBasedOnMenuItemWidth(false),
            .selectionIndicatorHeight(2.0),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .scrollAnimationDurationOnMenuItemTap(300)
        ]
        
        self.pageMenu = CAPSPageMenu(viewControllers: controllerArray,
                                     frame: CGRect(
                                        x:0.0,
                                        y: headerViewHeightConstraint.constant + 2,
                                        width: self.view.frame.width,
                                        height: self.view.frame.height - 80),
                                     pageMenuOptions: pageMenuParameters)
        
        self.view.addSubview(self.pageMenu!.view)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DiscoverViewController : DiscoverDelegate {
    func didSelectRowAt(indexPath: IndexPath, from parent: TabTitle) {
        
        switch parent {
        case .cases:
            let detail = cellArray[indexPath.row]
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            viewController.detail = detail
            self.navigationController?.pushViewController(viewController, animated: true)
        case .organisations:
            
            let detail = orgArray[indexPath.row]
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "OrganisationDetailViewController") as! OrganisationDetailViewController
            viewController.detail = detail
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}
