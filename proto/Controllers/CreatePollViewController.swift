//
//  CreatePollViewController.swift
//  proto
//
//  Created by Alexander Murphy on 10/26/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import Player
import AVFoundation

class CreatePollViewController: UIViewController, VideoCameraModalViewControllerDelegate, PlayerDelegate {
    var croppingEnabled: Bool = true
    var libraryEnabled: Bool = true
    private var player: Player!
    public var optionOneVideoURL: URL?
    public var optionTwoVideoUrl: URL?
    
    var Player1: Player = Player()
    var Player2: Player = Player()

    var optionNumber: Int?
    
    @IBOutlet weak var pollFormatSegment: UISegmentedControl!
    @IBOutlet weak var optionOneImageView: UIImageView!
    @IBOutlet weak var optionTwoImageView: UIImageView!
    @IBOutlet weak var optionOneVideoView: UIView!
    @IBOutlet weak var optionTwoVideoView: UIView!
    @IBOutlet var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVideoPlayer(videoView: optionOneVideoView, playerInstance: Player1)
        self.configureVideoPlayer(videoView: optionTwoVideoView, playerInstance: Player2)

        // crop circles
        ImageHelper.circleCrop(imageView: optionOneImageView)
        ImageHelper.circleCrop(imageView: optionTwoImageView)
        ViewHelper.circleCrop(view: optionOneVideoView)
        
        if(self.optionOneVideoURL != nil) {
            //self.playVideo(videoURL: self.optionOneVideoURL!)
            self.optionOneImageView.image = VideoHelper.getVideoFirstFrame(videoURL: self.optionOneVideoURL!)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    internal func sendValue(value: URL) {
        mainView.bringSubview(toFront: optionOneVideoView)
        print("in main view controller", value)
        
        if (optionNumber == 1) {
            self.playVideo(videoURL: value, videoView: optionOneVideoView)
        } else {
            print("option two selected")
        }
        self.playVideo(videoURL: value, videoView: optionTwoVideoView)
    }
    
    func configureVideoPlayer(videoView: UIView, playerInstance: Player) {
        self.view.autoresizingMask = ([UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight])
        playerInstance.delegate = self
        playerInstance.view.frame = videoView.bounds
        self.addChildViewController(playerInstance)
        videoView.addSubview(playerInstance.view)
        playerInstance.didMove(toParentViewController: self)
        playerInstance.playbackLoops = false
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        playerInstance.view.addGestureRecognizer(tapGestureRecognizer)
    }
    

    
    func playVideo(videoURL: URL, videoView: UIView) {
        print("now playing video", videoURL)
        self.player.setUrl(videoURL)
        self.player.playFromBeginning()
    }
    
    // MARK: UIGestureRecognizer
    
    func handleTapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.stopped.rawValue:
            self.player.playFromBeginning()
        case PlaybackState.paused.rawValue:
            self.player.playFromCurrentTime()
        case PlaybackState.playing.rawValue:
            self.player.pause()
        case PlaybackState.failed.rawValue:
            self.player.pause()
        default:
            self.player.pause()
        }
    }
    
    // MARK: PlayerDelegate
    
    func playerReady(_ player: Player) {
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
    }
    
    func playerCurrentTimeDidChange(_ player: Player) {
    }
    
    func playerWillComeThroughLoop(_ player: Player) {
        
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
        else if(currentSegmentState() == "video") {
            // have we recorded video yet?
            if(self.optionOneVideoURL != nil) {
                optionNumber = 1
                self.mainView.bringSubview(toFront: optionOneVideoView)
                self.playVideo(videoURL: self.optionOneVideoURL!, videoView: self.optionOneVideoView)
            } else {
                performSegue(withIdentifier: "showVideoCamera", sender: self)
            }
        }
//        else if(currentSegmetState() == "voice" {
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
