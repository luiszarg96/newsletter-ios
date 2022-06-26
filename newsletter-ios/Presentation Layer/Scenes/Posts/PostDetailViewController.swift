//
//  PostDetailViewController.swift
//  newsletter-ios
//
//  Created by dev on 2022-06-25.
//

import Foundation
import UIKit


class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorUsernameLabel: UILabel!
    @IBOutlet weak var authorEmailLabel: UILabel!
    @IBOutlet weak var authorPhoneLabel: UILabel!
    @IBOutlet weak var authorWebsiteLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImageView: UIImageView!
    
    var viewModel = PostsViewModel()

    var headerImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.getComments {
            self.tableView.reloadData()
        }
        
        viewModel.getAuthor {
            self.setupAuthorView()
        }
    }
    
    private func setupView() {
        
        headerImageView.image = headerImage
        tableView.delegate = self
        tableView.dataSource = self
        postTitleLabel.text = viewModel.selectedPost.title ?? ""
        postBodyLabel.text = viewModel.selectedPost.body ?? ""
        
    }
    
    private func setupAuthorView() {
        
        authorImageView.layer.borderColor = UIColor.systemGreen.cgColor
        authorImageView.layer.borderWidth = 3
        authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
        authorNameLabel.text = viewModel.author.name
        authorUsernameLabel.text = "(\(viewModel.author.formattedUsername))"
        authorEmailLabel.text = viewModel.author.email
        authorPhoneLabel.text = viewModel.author.phone
        authorWebsiteLabel.text = viewModel.author.website
        
    }
    

    
}


extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.commentTableViewCellID, for: indexPath)!
        cell.configure(comment: viewModel.comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
