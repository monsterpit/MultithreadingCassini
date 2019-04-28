//
//  CassiniViewController.swift
//  MultithreadingCassini
//
//  Created by MB on 4/28/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // getting segue identifer
        if let identifier = segue.identifier{
            //getting url from constant DemoUrl if segue identifier name key was present
            if let url = DemoURLs.NASA[identifier]{
                
                var destination = segue.destination
                
                if let navcon = destination as? UINavigationController{
                    destination = navcon.visibleViewController ?? navcon
                }
                
                if let imageVC = destination as? ImageViewController{

                    imageVC.imageURL = url
                    
                    imageVC.title = (sender as? UIButton)?.currentTitle

                }
            }
        }
    }


}



/*
 So after running Ui was getting stuck when trying to rotate my Ui was just blank doing nothing
 So our UI is completely stuck
 No matter where I touch even if I rotate nothinhg happened
 Well this ia horrendous experience for your user
 This is the kind of experience that will cause your user to go and delete app
 Because you cannot have your UI freezing up so that's why we have multi threaded as such an important piece of the kind of app development do in iOS
 So lets fix this with multi threading 
 */
