//
//  CreatePollViewController.swift
//  proto
//
//  Created by Alexander Murphy on 10/26/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit

class CreatePollViewController: UIViewController {
    var croppingEnabled: Bool = true
    var libraryEnabled: Bool = true
    

    @IBOutlet weak var pollFormatSegment: UISegmentedControl!
    @IBOutlet weak var optionOneImageView: UIImageView!
    @IBOutlet weak var optionTwoImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // crop circles
        circleCrop(imageView: optionOneImageView)
        circleCrop(imageView: optionTwoImageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // utility functions
    func circleCrop(imageView: UIImageView) {
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }
    
    func currentSegmentState() -> String {
        if(pollFormatSegment.selectedSegmentIndex == 0) {
            return "photo"
        }
        else if(pollFormatSegment.selectedSegmentIndex == 1) {
            return "video"
        }
        else if(pollFormatSegment.selectedSegmentIndex == 2) {
            return "voice"
        } else {
            return "none"
        }
    }
    
    @IBAction func addOptionOne(_ sender: AnyObject) {
        
        if(currentSegmentState() == "photo"){
            let cameraViewController = CameraViewController(croppingEnabled: croppingEnabled, allowsLibraryAccess: libraryEnabled) { [weak self] image, asset in
                //self?.imageView.image = image
                self?.optionOneImageView.image = image
                self?.dismiss(animated: true, completion: nil)
            }
            present(cameraViewController, animated: true, completion: nil)
        }
//        else if(currentSegmentState() == "video") {
//            
//        }
//        else if(currentSegmentState() == "voice" {
//            
//        }
    }
   
   
    @IBAction func addOptionTwo(_ sender: AnyObject) {
        if(currentSegmentState() == "photo"){
            let cameraViewController = CameraViewController(croppingEnabled: croppingEnabled, allowsLibraryAccess: libraryEnabled) { [weak self] image, asset in
                //self?.imageView.image = image
                self?.optionTwoImageView.image = image
                self?.dismiss(animated: true, completion: nil)
            }
            present(cameraViewController, animated: true, completion: nil)
        }
//        else if(currentSegmentState() == "video") {
//            
//        }
//        else if(currentSegmentState() == "voice" {
//            
//        }
    }

    @IBAction func pollFormatChange(_ sender: AnyObject) {

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
