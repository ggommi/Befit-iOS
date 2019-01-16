//
//  LoadVC.swift
//  Befit
//
//  Created by 박다영 on 11/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import UIKit
import Lottie

class LoadVC: UIViewController ,URLSessionDownloadDelegate {
    
    private var downloadTask: URLSessionDownloadTask?
    private var boatAnimation: LOTAnimationView?
    var positionInterpolator: LOTPointInterpolatorCallback?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Boat Animation
        boatAnimation = LOTAnimationView(name: "material_wave_loading")
        
        // Set view to full screen, aspectFit
        boatAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        boatAnimation!.contentMode = .scaleAspectFill
        boatAnimation!.frame = view.bounds
        
        // Add the Animation
        view.addSubview(boatAnimation!)
        
        
        // The center of the screen, where the boat will start
        let screenCenter = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        // The center one screen height above the screen. Where the boat will end up when the download completes
        let offscreenCenter = CGPoint(x: view.bounds.midX, y: -view.bounds.midY)
        
        // Convert points into animation view coordinate space.
        let boatStartPoint = boatAnimation!.convert(screenCenter, toKeypathLayer: LOTKeypath(string: "Boat"))
        
        let boatEndPoint = boatAnimation!.convert(offscreenCenter, toKeypathLayer: LOTKeypath(string: "Boat"))
        
        // Set up out interpolator, to be driven by the download callback
        positionInterpolator = LOTPointInterpolatorCallback(from: boatStartPoint, to: boatEndPoint)
        // Set the interpolator on the animation view for the Boat.Transform.Position keypath.
        boatAnimation!.setValueDelegate(positionInterpolator!, for: LOTKeypath(string: "Boat.Transform.Position"))
        
        //Play the first portion of the animation on loop until the download finishes.
        boatAnimation!.loopAnimation = true
        boatAnimation!.play(fromProgress: 0,
                            toProgress: 0.5,
                            withCompletion: nil)

    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        // Pause the animation and disable looping.
        boatAnimation!.pause()
        boatAnimation!.loopAnimation = false
        // Speed up animation to finish out the current loop.
        boatAnimation!.animationSpeed = 4
        
        boatAnimation!.play(toProgress: 0.5) {[weak self] (_) in
            // At this time the animation is at the halfway point. Reset sped to 1 and play through the completion animation.
            self?.boatAnimation!.animationSpeed = 1
            self?.boatAnimation!.play(toProgress: 1, withCompletion: nil)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        positionInterpolator?.currentProgress = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
    }
    


}
