//
//  ImageViewController.swift
//  Cassini
//
//  Created by Boppo on 25/04/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController , UIScrollViewDelegate {
    
    var imageURL : URL?{
        didSet{
            
            image = nil
            
            if view.window != nil{
                
                fetchImage()
            }
        }
    }
    
    private var image : UIImage?{
        get
        {
           return imageView.image
        }
        set
        {
            imageView.image = newValue
            
            imageView.sizeToFit()
            // how about we optional chain it
            //that's make it this line will be ignored if scrollView is nil
            // all that's happening here is that we are setting to image to nil
            // it's for just preparing its going to start out nil
            scrollView?.contentSize = imageView.frame.size
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if imageView.image == nil{
            fetchImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{

        didSet{
            
            scrollView.minimumZoomScale = 1/25
            
            // max to 1 so bits doesnt looks pixelated so i wont let you zoom in any more than 1.0
            scrollView.maximumZoomScale = 1
            
            scrollView.delegate = self
            
            scrollView.addSubview(imageView)

        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //returning imageView because that's the subview we want to be transformed when we pinch
        return imageView
    }
    
    
    //this create a imageView of size zero
    var imageView = UIImageView()
    
    func fetchImage(){
        
        if let url = imageURL{
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    if let imageData = urlContents{
                        
                        self?.image = UIImage(data: imageData)
                        
                    }
                }

                /*
                 while this will stop my UI from blocking it will probably screwup my UI
                 probably cause my UI to draw all funny or get completely wedged and why is that?
                 
                 because this line of code
                 self?.image = UIImage(data: imageData)
                 because here I am setting image
                 and in line 30 set of private var image
                 we are setting
                 imageView.image which is a UI thing
                 imageView.sizeToFit() sizzing to fit which is a UI thing
                 scrollView?.contentSize = imageView.frame.size which is setting scrollView contentArea which is a  Ui thing
                 
                 So we are doing all kind of UI stuffs when I set this image
                 So I cant do this on the queue that I put this code on
                 
                 This
                 DispatchQueue.global(qos: .userInitiated).async
                 is not a UI queue
                 i cant do it there,
                 So what I have to do here is
                 DispatchQueue.main.async{}
                 
                 This dispatches the code back to main queue
                 Now it's gonna get in line and run on the main queue when the main queue is quiet
                 */
                
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // by the time I load if my imageURl is nil then load up a sample image
        if imageURL == nil {
            
            imageURL = DemoURLs.standford
        }
    }
    
    
}


//easier in code than IB

//zooming
//set min and max zoom scale
//provide a delegate that says which is a view to zoom
//now it's obvious which view we want the transform to work on here its our imageView


//option key + drag in simulator to pinch 
