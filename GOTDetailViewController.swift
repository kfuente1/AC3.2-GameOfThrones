//
//  GOTDetailViewController.swift
//  AC3.2-GameOfThrones
//
//  Created by Karen Fuentes on 10/12/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GOTDetailViewController: UIViewController {
    
    var image: UIImage?
    var data: Data?
    var color =  UIColor()
    
    var selectedGOTEpisode: GOTEpisode?

    @IBOutlet weak var episodePoster: UIImageView!
    @IBOutlet weak var episodesName: UILabel!
    @IBOutlet weak var summary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesName.text = selectedGOTEpisode?.name
        summary.text = selectedGOTEpisode?.summary
        let urlString = URL(string: (selectedGOTEpisode?.image)!)
        if let unwrappedURL = urlString {
            data = try? Data.init(contentsOf: unwrappedURL)
        }
        if let realData = data {
            episodePoster.image = UIImage(data: realData)
            
        }
        
        self.view.backgroundColor = randomColor()
        
    
    

        // Do any additional setup after loading the view.
    }
    
    func random ()-> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
        
    }
   
    func randomColor() -> UIColor {
        let newcolor = UIColor(red:   random(),
                               green: random(),
                               blue:  random(),
                               alpha: 1.0)
        
        color = newcolor
        return color
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




