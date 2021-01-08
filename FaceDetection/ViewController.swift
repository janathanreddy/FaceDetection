//
//  ViewController.swift
//  FaceDetection
//
//  Created by Janarthan Subburaj on 08/01/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var PhotoBtn: UIButton!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func PhotoAct(_ sender: Any){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action in
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
            }))
        }
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            picker.sourceType = .photoLibrary
            // on iPad we are required to present this as a popover
            if UIDevice.current.userInterfaceIdiom == .pad {
                picker.modalPresentationStyle = .popover
                picker.popoverPresentationController?.sourceView = self.view
                picker.popoverPresentationController?.sourceRect = self.PhotoBtn.frame
            }
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // on iPad this is a popover
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = PhotoBtn.frame
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
        performSegue(withIdentifier: "showImageSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImageSegue" {
            if let DetectViewController = segue.destination as? DetectViewController {
                DetectViewController.image = self.image
            }
        }
    }
    
    
    
}

