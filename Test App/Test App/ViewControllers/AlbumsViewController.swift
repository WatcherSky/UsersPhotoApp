//
//  AlbumsViewController.swift
//  Test App
//
//  Created by Владимир on 20.01.2022.
//

import UIKit

class AlbumsViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak private var collectionView: UICollectionView!
    var id = 0
    private let collectionViewCellId = "id"
    private var albums = [ResultsAlbums]()
    
    //MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbums(id: id)
        setupCollectionView()
    }
    
    //MARK: - Functions
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: collectionViewCellId)
    }
    
    private func getAlbums(id: Int) {
        let url = "https://jsonplaceholder.typicode.com/albums/\(id)/photos"
        NetworkManager.shared.getAlbumsData(urlString: url) { [unowned self] (resultsData) in
            guard let resultsData = resultsData else { return }
            for results in 0..<resultsData.count {
                albums.append(resultsData[results])
            }
            collectionView.reloadData()
        }
    }
}

    //MARK: - Extensions
extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as! CollectionViewCell
        cell.activityIndicator.startAnimating()
        DispatchQueue.main.async {
            let url = URL(string: self.albums[indexPath.item].url)
            ImageCachingManager.shared.downloadImage(url: url!) { image in
                cell.imageView.image = image
                cell.activityIndicator.stopAnimating()
            }
        }
        cell.labelView.text = self.albums[indexPath.item].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width - 20, height: self.collectionView.bounds.height - 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
