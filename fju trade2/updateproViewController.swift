//
//  updateproViewController.swift
//  fju trade2
//
//  Created by PC_17 on 2018/1/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class updateproViewController: UIViewController {
    var uid : String=(Auth.auth().currentUser?.uid)!


    @IBOutlet weak var newname: UITextField!
    @IBOutlet weak var newphone: UITextField!
    @IBOutlet weak var newline: UITextField!
    
    @IBAction func confirm(_ sender: UIButton) {
    
    let name = newname.text
        let phone = newphone.text
        let line = newline.text
        
        let ref = Database.database().reference().child("account").child(uid)
        ref.updateChildValues(["name" : name,
                               "phone":phone,
                               "line":line,
                               
                               ])
        let _=self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func back(_ sender: UIButton) {
    
    navigationController?.popViewController(animated: true)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let tryDatabase = Database.database().reference()
        tryDatabase.child("account").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.newname.text=value?["name"] as? String ?? ""
            self.newphone.text=value?["phone"] as? String ?? ""
            self.newline.text=value?["line"] as? String ?? ""
     // Do any additional setup after loading the view.
         }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

