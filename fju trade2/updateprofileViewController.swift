//
//  updateprofileViewController.swift
//  fju trade2
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class updateprofileViewController: UIViewController {
    var uid : String=""
    @IBOutlet weak var newname: UITextField!
    @IBOutlet weak var newphone: UITextField!
    @IBOutlet weak var newline: UITextField!
    
    
    @IBAction func confirm(_ sender: Any) {
        let name = newname.text
        let phone = newphone.text
        let line = newline.text
        
        let ref = Database.database().reference().child("account").child(uid)
        ref.updateChildValues(["name" : newname,
                               "phone":newphone,
                               "line":newline,
                              
            ])
        let loginview = UIStoryboard(name: "Main" , bundle:nil).instantiateViewController(withIdentifier: "profile")
        //present(loginview, animated:true, completion: nil)
        self.navigationController?.pushViewController(loginview, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tryDatabase = Database.database().reference()
        tryDatabase.child("account").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.newname.text=value?["name"] as? String ?? ""
            self.newphone.text=value?["phone"] as? String ?? ""
            self.newline.text=value?["line"] as? String ?? ""
        }

      
    
    
   
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

