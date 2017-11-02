//
//  UserItem.swift
//  geoMessenger
//
//  Created by Ivor D. Addo, PhD on 11/1/17.
//  Copyright © 2017 water. All rights reserved.
//

import Foundation
import Firebase

struct UserItem {
    
    let key: String
    let firstName: String
    let lastName: String
    let ref: DatabaseReference?
    var isApproved: Bool
    
    init(firstName: String, lastName: String, isApproved: Bool, key: String = "") {
        self.key = key
        self.firstName = firstName
        self.lastName = lastName
        self.isApproved = isApproved
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        lastName = snapshotValue["LastName"] as! String
        firstName = snapshotValue["FirstName"] as! String
        isApproved = snapshotValue["IsApproved"] as! Bool
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "lastName": lastName,
            "firstName": firstName,
            "isApproved": isApproved
        ]
    }
}
