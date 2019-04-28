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
                
                if let imageVC = segue.destination.contents as? ImageViewController{

                    imageVC.imageURL = url
                    
                    imageVC.title = (sender as? UIButton)?.currentTitle

                }
            }
        }
    }


}



extension UIViewController{
    var contents : UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController ?? self
        }
            // For TabBar
//        else if let navcon = self as? UITabBarController{
//            return navcon.selectedViewController ?? self
//        }
        else{
            return self
        }
    }
}

