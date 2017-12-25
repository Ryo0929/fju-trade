//
//  postViewController.swift
//  fju trade2
//
//  Created by Apple on 2017/12/15.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseStorageUI
import FirebaseAuth
class postViewController: UIViewController,UITextViewDelegate{
    var imgurl:String?
    var isnew:Bool?
    var selectedImageFromPicker: UIImage?
    @IBOutlet weak var pricetextfield: UITextField!
    @IBOutlet weak var nametextfield: UITextField!
    @IBOutlet weak var checknew: UIImageView!
    @IBOutlet weak var checksceondhand: UIImageView!
    @IBOutlet weak var myscrollview: UIScrollView!
    @IBOutlet weak var mytextarea: UITextView!
    @IBOutlet weak var uploadedimg: UIImageView!
    @IBOutlet weak var uploadimagebtn: UIButton!
    
    
    @IBAction func back(_ sender: UIButton) {
        let _=navigationController?.popViewController(animated: true)
    }
    @IBAction func uploadimage(_ sender: UIButton) {
        uploadedimg.isHidden=true;//因為還沒上傳照片，先隱藏imageview
        
        // 建立一個 UIImagePickerController 的實體
        let imagePickerController = UIImagePickerController()
        
        // 委任代理
        imagePickerController.delegate=self
        
        // 建立一個 UIAlertController 的實體
        // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
        let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)
        
        // 建立三個 UIAlertAction 的實體
        // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (Void) in
            
            // 判斷是否可以從照片圖庫取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (Void) in
            // 判斷是否可以從相機取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.camera)，並 present UIImagePickerController
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        // 新增一個取消動作，讓使用者可以跳出 UIAlertController
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Void) in
            
            imagePickerAlertController.dismiss(animated: true, completion: nil)
        }
        
        // 將上面三個 UIAlertAction 動作加入 UIAlertController
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
        
        // 當使用者按下 uploadBtnAction 時會 present 剛剛建立好的三個 UIAlertAction 動作與
        present(imagePickerAlertController, animated: true,completion: nil)
    }
    override func viewDidLoad() {
        checknew.isHidden=true
        checksceondhand.isHidden=true
        mytextarea.delegate=self
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            myscrollview.contentInset = UIEdgeInsets.zero
        } else {
            myscrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        myscrollview.scrollIndicatorInsets = myscrollview.contentInset
        let scrollviewheight=myscrollview.contentSize.height-216
        let myCGRect=CGRect.init(x:100,y:scrollviewheight,width:100,height:100)
    
        myscrollview.scrollRectToVisible(myCGRect, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func newbtn(_ sender: UIButton) {
        checknew.isHidden=false
        checksceondhand.isHidden=true
        isnew=true
    }
    @IBAction func secondbtn(_ sender: UIButton) {
        checknew.isHidden=true
        checksceondhand.isHidden=false
        isnew=false
    }
    @IBAction func post(_ sender: UIButton) {
        // 可以自動產生一組獨一無二的 ID 號碼，方便等一下上傳圖片的命名
        let uniqueString = NSUUID().uuidString
        // 當判斷有 selectedImage 時，我們會在 if 判斷式裡將圖片上傳
        if let selectedImage = selectedImageFromPicker {
            let storageRef = Storage.storage().reference().child("AppCodaFireUpload").child("\(uniqueString).png")
            
            if let uploadData = UIImagePNGRepresentation(selectedImage) {
                // 這行就是 FirebaseStorage 關鍵的存取方法。
                storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in
                    
                    if error != nil {
                        
                        // 若有接收到錯誤，我們就直接印在 Console 就好，在這邊就不另外做處理。
                        print("Error: \(error!.localizedDescription)")
                        return
                    }
                    
                    // 連結取得方式就是：data?.downloadURL()?.absoluteString。
                    if let uploadImageUrl = data?.downloadURL()?.absoluteString {
                        
                        // 我們可以 print 出來看看這個連結事不是我們剛剛所上傳的照片。
                        print("Photo Url: \(uploadImageUrl)")
                        self.imgurl=uploadImageUrl;
                        let databaseRef = Database.database().reference().child("AppCodaFireUpload").child(uniqueString)
                        
                        databaseRef.setValue(uploadImageUrl, withCompletionBlock: { (error, dataRef) in
                            
                            if error != nil {
                                
                                print("Database Error: \(error!.localizedDescription)")
                            }
                            else {
                                
                                print("圖片已儲存")
                                let name:String?=self.nametextfield.text
                                let price:String?=self.pricetextfield.text
                                let story:String?=self.mytextarea.text
                                var ref: DatabaseReference!
                                ref = Database.database().reference().child("product").child(uniqueString)
                                let productdata=[
                                    "productid":uniqueString,
                                    "imageURL":self.imgurl,
                                    "name":name,
                                    "price":price,
                                    "story":story,
                                    "isnew":self.isnew
                                    
                                    ] as [String : Any]
                                ref.setValue(productdata)
                                let alert = UIAlertController(title: "上傳成功", message: "", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "ok!", style: UIAlertActionStyle.default, handler: {
                                    (action: UIAlertAction!) -> Void in
                                    let _=self.navigationController?.popViewController(animated: true)
                                }))
                                self.present(alert, animated: true, completion: nil)
                                                             }
                            
                        })
                    }
                })
            }
            
            print("\(uniqueString), \(selectedImage)")
        }
        
    }
}

    

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension postViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
       
        
        // 取得從 UIImagePickerController 選擇的檔案
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.selectedImageFromPicker = pickedImage
            self.uploadedimg.image=selectedImageFromPicker
            self.uploadedimg.isHidden=false
            self.uploadimagebtn.isHidden=true
        }
        
       
        
        
        
        dismiss(animated: true, completion: nil)
    }
}


