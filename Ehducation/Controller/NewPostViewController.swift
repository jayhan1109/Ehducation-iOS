//
//  NewPostViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-09.
//

import UIKit
import DropDown
import PhotosUI

class NewPostViewController: UIViewController {
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var gradeButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    
    let gradeDropdown = DropDown()
    let subjectDropdown = DropDown()
    
    var imageViews: [UIImageView] = []
    var clearViews: [UIButton] = []
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func gradePressed(_ sender: UIButton) {
        gradeDropdown.show()
    }
    @IBAction func subjectPressed(_ sender: Any) {
        subjectDropdown.show()
    }
    
    @IBAction func addImageButton(_ sender: UIButton) {
        if #available(iOS 14, *) {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 5
            configuration.filter = .any(of: [.images, .videos])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
            print(images.count)
        } else {
            // Fallback on earlier versions
        }
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
                        DispatchQueue.main.async {
                            self.imageViews[idx].image = img
                            self.images.append(img)
                        }
                    }
                }
            } else {
                // TODO: Handle empty results or item provider not being able load UIImage
            }
        }
    }
}
