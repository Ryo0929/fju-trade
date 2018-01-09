//
//  personfileViewController.swift
//  fju trade2
//
//  Created by Apple on 2018/1/5.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class personfileViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var line: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func letsTradeBtn(_ sender: UIButton) {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("account").child(Auth.auth().currentUser!.uid)
        let accountdata=[
            "uid":Auth.auth().currentUser!.uid,
            "name":self.name.text,
            "line":self.line.text,
            "phone":self.phone.text,
            ] as [String : Any]
        ref.setValue(accountdata)
        let mainviewview = UIStoryboard(name: "Main" , bundle:nil).instantiateViewController(withIdentifier: "mainview")
        self.navigationController?.pushViewController(mainviewview, animated: true)            
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
