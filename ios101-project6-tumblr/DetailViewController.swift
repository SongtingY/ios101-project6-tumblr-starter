//
//  DetailViewController.swift
//  ios101-project6-tumblr
//
//  Created by songting yang on 3/29/24.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    var post: Post!
    var posts: [Post]!
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        textView.text = post.caption.trimHTMLTags()
        
        if let imagePath = post.photos.first?.originalSize.url {
            Nuke.loadImage(with: imagePath, into: imageView)
        }
        // Do any additional setup after loading the view.
        setupNextButton()
    }
    
    func setupNextButton() {
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(goToNextPost))
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func goToNextPost() {
        currentIndex += 1
        guard currentIndex < posts.count else {
            print("No more posts")
            currentIndex -= 1 // Reset to the last valid index
            return
        }
        let nextPost = posts[currentIndex]
        self.post = nextPost // Update the current post with the next one
        updateViewForPost(nextPost) // Update the view with the new post
    }
    
    func updateViewForPost(_ post: Post) {
        textView.text = post.caption.trimHTMLTags()
        if let imagePath = post.photos.first?.originalSize.url {
            Nuke.loadImage(with: imagePath, into: imageView)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}