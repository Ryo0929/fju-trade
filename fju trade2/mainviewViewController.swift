//
//  mainviewViewController.swift
//  fju trade2
//
//  Created by Apple on 2017/12/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseStorageUI
class mainviewViewController: UIViewController {
    
    @IBOutlet weak var test: UIImageView!
    override func viewDidLoad() {
        let storage = Storage.storage()
        let gsReference = storage.reference(forURL: "gs://fju-trade.appspot.com/AppCodaFireUpload/27672999-E324-431E-A40D-F3CDA5C5B0C1.png")
        let placeholderImage = UIImage(named: "placeholder.jpg")
        test.sd_setImage(with: gsReference, placeholderImage: placeholderImage)

        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
