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
    
    // MARK: - IBOutlet
    
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
    
    // MARK: - Properties
    
    let gradeDropdown = DropDown()
    let subjectDropdown = DropDown()
    
    var imageViews: [UIImageView] = []
    var images: [Data] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor(named: K.Colors.pageBackgroundColor)
        
        postButton.layer.cornerRadius = postButton.frame.height / 5
        
        configureDropdown()
        
        imageViews = [imageView1, imageView2, imageView3, imageView4, imageView5]
        
    }
    
    // Dismiss keyboard when touch outside of textView and textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.endEditing(true)
        titleTextField.endEditing(true)
    }
    
    // MARK: - IBAction
    
    // Show grade dropdown
    @IBAction func gradePressed(_ sender: UIButton) {
        gradeDropdown.show()
    }
    
    // Show subject dropdown
    @IBAction func subjectPressed(_ sender: Any) {
        subjectDropdown.show()
    }
    
    // Set up PHPhotoLibrary and present it
    // After picking up images, handle at deleagate function
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
    
    // Create a post
    @IBAction func postPressed(_ sender: UIButton) {
        // Check if title, grade, subject, text are not empty
        if hasEmptyField() {
            return
        }
        
        let timestamp = Date().timeIntervalSince1970
        var path: String?
        
        // If there are images, upload them to Firestorage
        if images.count > 0 {
            path = FirebaseManager.shared.uploadImage(images: images, timestamp: timestamp)
        }
        
        // Create Post model instance
        let post = Post(userId: FirebaseManager.shared.user!.id, timestamp: timestamp, grade: gradeButton.currentTitle!, subject: subjectButton.currentTitle!, title: titleTextField.text!, text: textView.text!, imageRef: path ?? "", viewCount: 0, answerCount: 0, imageCount: images.count)
        
        // Save Post instance into Firestore
        FirebaseManager.shared.createPost(with: post)
        
        // Return to Questions page
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    // Configure grade and subject dropdown
    func configureDropdown(){
        gradeButton.layer.cornerRadius = gradeButton.frame.height / 5
        subjectButton.layer.cornerRadius = subjectButton.frame.height / 5
        
        subjectDropdown.anchorView = subjectButton
        subjectDropdown.dataSource = K.subjects
        
        subjectDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            subjectButton.setTitle(item, for: .normal)
        }
        subjectDropdown.backgroundColor = UIColor(named: K.Colors.pageBackgroundColor)
        subjectDropdown.textColor = UIColor(named: K.Colors.textPrimaryColor)!
        subjectDropdown.selectionBackgroundColor = UIColor(named: K.Colors.primaryColor)!
        
        gradeDropdown.anchorView = gradeButton
        gradeDropdown.dataSource = K.grades
        
        gradeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            gradeButton.setTitle(item, for: .normal)
        }
        gradeDropdown.backgroundColor = UIColor(named: K.Colors.pageBackgroundColor)
        gradeDropdown.textColor = UIColor(named: K.Colors.textPrimaryColor)!
        gradeDropdown.selectionBackgroundColor = UIColor(named: K.Colors.primaryColor)!
    }
    
    // Check if any textfields or dropdowns are empty and show alert to user
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
            let alert = FirebaseManager.shared.generateAlert(title: "Subject", isTextField: false)
            self.present(alert, animated: true, completion: nil)
            
            return true
        }
        
        return false
    }
}

// MARK: - PHPickerViewControllerDelegate

extension NewPostViewController: PHPickerViewControllerDelegate {
    
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        // Remove current images in image views
        for imgView in imageViews{
            imgView.image = .none
        }
        
        images = []
        
        // Load images and set each image to each image view
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
