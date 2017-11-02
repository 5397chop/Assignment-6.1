//
//  ViewController.swift
//  geoMessenger
//
//  Created by Ivor D. Addo, PhD on 11/1/17.
//  Copyright © 2017 water. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBAction func btnAddUser(_ sender: CustomButton) {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        let userTable : [String : Any] =
            ["FirstName": txtFirstName.text!,
             "LastName": txtLastName.text!,
             "IsApproved": false]
        
        ref.child("MyUsers").childByAutoId().setValue(userTable)
        
        let ac = UIAlertController(title: "User Saved!", message: "The user information was saved successfully!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        txtFirstName.text = nil
        txtLastName.text = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
        // Dispose of any resources that can be recreated.
    }

}
