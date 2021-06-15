//
//  NewPostViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-09.
//

import UIKit
import DropDown
import PhotosUI

class NewPostViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var gradeButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    let gradeDropdown = DropDown()
    let subjectDropdown = DropDown()
    
    var imageViews: [UIImageView] = []
    var clearViews: [UIButton] = []
    var images: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor(named: K.Colors.pageBackgroundColor)
        
        postButton.layer.cornerRadius = postButton.frame.height / 5
        gradeButton.layer.cornerRadius = gradeButton.frame.height / 5
        subjectButton.layer.cornerRadius = subjectButton.frame.height / 5
        
        subjectDropdown.anchorView = subjectButton
        subjectDropdown.dataSource = ["English", "Math", "Science"]
        
        subjectDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            subjectButton.setTitle(item, for: .normal)
        }
        
        gradeDropdown.anchorView = gradeButton
        gradeDropdown.dataSource = ["8", "9", "10"]
        
        gradeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            gradeButton.setTitle(item, for: .normal)
        }
        
        imageViews = [imageView1, imageView2, imageView3, imageView4, imageView5]
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.endEditing(true)
        titleTextField.endEditing(true)
    }
    
    @IBAction func gradePressed(_ sender: UIButton) {
        gradeDropdown.show()
    }
    @IBAction func subjectPressed(_ sender: Any) {
        subjectDropdown.show()
    }
    
    @IBAction func addImageButton(_ sender: UIButton) {
        if #available(iOS 14, *) {
            let photoLibrary = PHPhotoLibrary.shared()
            var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)
            configuration.selectionLimit = 5
            configuration.filter = .any(of: [.images, .videos])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func postPressed(_ sender: UIButton) {
        // Check if title, grade, subject, text are not empty
        if hasEmptyField() {
            return
        }
        
        print("All Good")
        
//        let timestamp = Date().timeIntervalSince1970
//
//        // Upload images into firebase storage
//        let path = FirebaseManager.shared.uploadImage(images: images, timestamp: timestamp)
//
//        // Create Post model instance
//        Post(userId: FirebaseManager.shared.user!.id, timestamp: timestamp, grade: gradeButton.currentTitle!, subject: <#T##String#>, title: <#T##String#>, text: <#T##String#>, imageRef: <#T##String#>, viewCount: <#T##Int#>, answerCount: <#T##Int#>, imageCount: <#T##Int#>)
//
//        // Save Post instance into Firestore
//
//        // Return to Questions page
//
//        // Reload Questions page tableview data
    }
    
    func hasEmptyField() -> Bool{
        if titleTextField.text == "" {
            let alert = FirebaseManager.shared.generateAlert(title: "Title", isTextField: true)
            self.present(alert, animated: true, completion: nil)
            
            return true
        }
        
        if textView.text == "" {
            let alert = FirebaseManager.shared.generateAlert(title: "Content", isTextField: true)
            self.present(alert, animated: true, completion: nil)
            
            return true
        }
        
        if gradeButton.currentTitle == "Grade" {
            let alert = FirebaseManager.shared.generateAlert(title: "Grade", isTextField: false)
            self.present(alert, animated: true, completion: nil)
            
            return true
        }
        
        if subjectButton.currentTitle == "Subject" {
            let alert = FirebaseManager.shared.generateAlert(title: "Title", isTextField: true)
            self.present(alert, animated: true, completion: nil)
            
            return true
        }
        
        return false
    }
}

extension NewPostViewController: PHPickerViewControllerDelegate {
    
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        for imgView in imageViews{
            imgView.image = .none
        }
        
        images = []
        
        for idx in 0..<results.count{
            let itemProvider = results[idx].itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let img = image as? UIImage{
                        // Store image data to images array
                        if let pngData = img.pngData() {
                            self.images.append(pngData)
                            
                            // Update UI
                            DispatchQueue.main.async {
                                self.imageViews[idx].image = img
                            }
                        }
                    }
                }
            } else {
                // TODO: Handle empty results or item provider not being able load UIImage
            }
        }
        
    }
}
