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
                
                if let imageVC = segue.destination as? ImageViewController{
                    // scrollView is nil
                    // imageView was set to nil
                    // oh imageURL was set by segue 
                    //oops crashed when run prepares happens before outlets are set
                    imageVC.imageURL = url
                    
                    imageVC.title = (sender as? UIButton)?.currentTitle
                    // is setting VC title with UIbutton title bad?
                    // no it's not because you are not setting that titel of that destination imageVC to be same title as the button  , but presumably the button is localized to the local language so i am putting button title as in the title
                    // could also used tableView could had added new things and could had easily picked which one was pressed by its index in the table
                }
            }
        }
    }


}
