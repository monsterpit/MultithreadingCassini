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
                    if let imageData = urlContents, url == self?.imageURL{
                        
                        self?.image = UIImage(data: imageData)
                        
                    }
                }

                /*
                    But DispatchQueue.main.async is happening perhaps a minute
                 after this line of code url = imageURL
                 
                 It's putting on another queue it might be blocking the network
                 Now that this leads us to another one last thing we need to do here is which is what happens if we request this thing
                 and not through our UI but some other UI ,
                 someone calls this imageURL and sets it to something else
                 They set this imageURL to something else and we go to fetch that image
                 
                 what happens when this image self?.image = UIImage(data: imageData) comes back we dont care about it
                 we are off on working on a new image , So when this comes back
                 we need to make sure that our current ImageURL is the URl we requested here
                 and we can easily do that by saying
                 url == self?.imageURL which is weak
                 So here we are just checking after this takes five minutes if that URl is  the one I asked for
                 because if its not idc about it anymore in this class
                 So this this is what i am talking about where when you are doing multithreading
                 you have to think about timing of things
                 because it might take a while and they might come back and things might be different than they were when you left
                 So this is really a great little peice of code to really understand  because it covers a lot of ground
                 from the weak self and checking this and dispatching back to main queue getting this one of the background queue
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
