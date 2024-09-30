//
//  ImageGridViewController.swift
//  Image Gallery
//
//  Created by Balkrishna Choudhary on 30/09/24.
//

import UIKit

class ImageGridViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = ImageGridViewModel()
    private var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        setupCollectionView()
        setupBindings()
        viewModel.fetchPhotos()
    }
    private func setupLoadingIndicator() {
           loadingIndicator = UIActivityIndicatorView(style: .large)
           loadingIndicator.center = view.center
           loadingIndicator.hidesWhenStopped = true
           view.addSubview(loadingIndicator)
       }
    private func setupCollectionView() {
          // Register the nib file for PhotoCell
          let nib = UINib(nibName: "PhotoCell", bundle: nil)
          collectionView.register(nib, forCellWithReuseIdentifier: "PhotoCell")
          
          collectionView.delegate = self
          collectionView.dataSource = self
          
          let layout = UICollectionViewFlowLayout()
          layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3 - 8, height: 100)
          layout.minimumInteritemSpacing = 6
          layout.minimumLineSpacing = 6
          collectionView.collectionViewLayout = layout
      }
    private func setupBindings() {
         viewModel.isLoading = { [weak self] isLoading in
             DispatchQueue.main.async {
                 if isLoading {
                     self?.loadingIndicator.startAnimating()
                 } else {
                     self?.loadingIndicator.stopAnimating()
                 }
             }
         }
         
         viewModel.didUpdatePhotos = { [weak self] in
             DispatchQueue.main.async {
                 self?.collectionView.reloadData()
             }
         }
         
         viewModel.didFailWithError = { [weak self] errorMessage in
             DispatchQueue.main.async {
                 self?.showErrorAlert(message: errorMessage)
             }
         }
     }
     
     private func showErrorAlert(message: String) {
         let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default))
         present(alert, animated: true)
     }
//    private func setupBindings() {
//        viewModel.didUpdatePhotos = { [weak self] in
//            self?.collectionView.reloadData()
//        }
//    }
}

extension ImageGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue the custom cell using the registered nib
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let photo = viewModel.photo(at: indexPath)
        cell.configure(with: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Ensure that "Main" matches the name of your storyboard (or use nil if using the main storyboard)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate ImageDetailViewController using the Storyboard ID
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController {
            
            // Assign the selected photo to the photo property of ImageDetailViewController
            detailVC.photo = viewModel.photo(at: indexPath)
            
            // Push the detail view controller onto the navigation stack
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

