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
    
    let gradeDropdown = DropDown()
    let subjectDropdown = DropDown()
    
    var itemProviders: [NSItemProvider] = []
    var iterator: IndexingIterator<[NSItemProvider]>?
    
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
            configuration.selectionLimit = 0
            configuration.filter = .any(of: [.images, .videos])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension NewPostViewController: PHPickerViewControllerDelegate {
    
    
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true) // 1
        
        let itemProvider = results.first?.itemProvider // 2
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // 4
                DispatchQueue.main.async {
                    print(image)
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}
