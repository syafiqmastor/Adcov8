//
//  DetailDataModel.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/29/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import Foundation


struct DetailDataModel {
    let id : String
    let title : String
    let image : String
    let age : Int
    let origin : String
    let sex : String
    let duration : String
    let waiting : String
    let supportNeeded : String
    let shortDescription : String
    let description : String
    let moneyNeed : String
    let moneyHave : String
    
    init(id : String, title : String, image : String, age : Int, origin : String, sex : String, duration : String, waiting : String, supportNeeded : String, shortDescription : String, description : String, moneyNeed : String, moneyHave: String) {
        self.id = id
        self.title = title
        self.image = image
        self.age = age
        self.origin = origin
        self.sex = sex
        self.duration = duration
        self.waiting = waiting
        self.supportNeeded = supportNeeded
        self.shortDescription = shortDescription
        self.description = description
        self.moneyNeed = moneyNeed
        self.moneyHave = moneyHave
    }
}


struct OrgDetailDataModel {
    let id : String
    let title : String
    let image : String
    let location : String
    let cases : [DetailDataModel]
    let description : String
    
    
    init(id : String, title : String, image : String, location : String, cases : [DetailDataModel], description : String) {
        self.id = id
        self.title = title
        self.image = image
        self.location = location
        self.cases = cases
        self.description = description
    }
}

struct TrackDetailDataModel {
    let id : String
    let title : String
    let image : String
    let description : String
    
    
    init(id : String, title : String, image : String, description : String) {
        self.id = id
        self.title = title
        self.image = image
        self.description = description
    }
}

struct UserDetailDataModel {
    let id : String
    let title : String
    let image : String
    let email : String
    
    
    init(id : String, title : String, image : String, email : String) {
        self.id = id
        self.title = title
        self.image = image
        self.email = email
    }
}
