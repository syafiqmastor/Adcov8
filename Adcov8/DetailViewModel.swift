//
//  DetailViewModel.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import Foundation



enum DetailViewModelItemType {
    case nameAndPicture
    case about
    case email
    case friend
    case attribute
}

protocol DetailViewModelItem {
    var type: DetailViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class ProfileViewModelAboutItem: DetailViewModelItem {
    var type: DetailViewModelItemType {
        return .about
    }
    
    var sectionTitle: String {
        return "About"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var about: String
    
    init(about: String) {
        self.about = about
    }
}
