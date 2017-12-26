//
//  ViewController.swift
//  fju trade2
//
//  Created by Apple on 2017/11/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func gotologin(_ sender: UIButton) {
        let loginview = UIStoryboard(name: "Main" , bundle:nil).instantiateViewController(withIdentifier: "login")
        //present(loginview, animated:true, completion: nil)
        self.navigationController?.pushViewController(loginview, animated: true)
        
    }
    
    @IBAction func gotocreateaccount(_ sender: UIButton) {
        let createaccountview = UIStoryboard(name: "Main" , bundle:nil).instantiateViewController(withIdentifier: "createaccount")
        self.navigationController?.pushViewController(createaccountview, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

