//
//  BottomViewController.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit

protocol BottomDelegate {
    func didSelectDonateButton(_ sender : UIButton)
}

class BottomViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    var delegate : BottomDelegate!
    let screenSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func donateButton(_ sender: UIButton) {
        delegate.didSelectDonateButton(sender)
        //Braintree sandbox
    }

    
    
}
