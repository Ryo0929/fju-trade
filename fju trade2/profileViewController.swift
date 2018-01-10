//
//  profileViewController.swift
//  fju trade2
//
//  Created by PC_18 on 2018/1/6.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class profileViewController: UIViewController {
    let currentuserid=Auth.auth().currentUser?.uid
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var fb: UILabel!
    override func viewDidLoad() {
        let tryDatabase = Database.database().reference()
        tryDatabase.child("account").child(currentuserid!).observeSingleEvent(of: .value){ (snapshot) in
         let value = snapshot.value as? NSDictionary
            self.id.text=value?["name"] as? String ?? ""
            self.phone.text=value?["phone"] as? String ?? ""
            self.line.text=value?["line"] as? String ?? ""
            self.fb.text=value?["name"] as? String ?? ""
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteaccount(_ sender: UIButton) {
        
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
