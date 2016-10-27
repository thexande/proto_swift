//
//  CreatePollViewController.swift
//  proto
//
//  Created by Alexander Murphy on 10/26/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit

class CreatePollViewController: UIViewController {
    var croppingEnabled: Bool = false
    var libraryEnabled: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func openOptionOneCamera(_ sender: AnyObject) {
        let cameraViewController = CameraViewController(croppingEnabled: croppingEnabled, allowsLibraryAccess: libraryEnabled) { [weak self] image, asset in
            //self?.imageView.image = image
            print(image)
            //self?.dismiss(animated: true, completion: nil)
        }
        
        present(cameraViewController, animated: true, completion: nil)
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
