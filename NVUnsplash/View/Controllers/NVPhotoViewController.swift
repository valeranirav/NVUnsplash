//
//  NVPhotoViewController.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import UIKit

class NVPhotoViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var topPullToRefreshControl:UIRefreshControl!
    
    var service: NVPhotoServiceProtocol?
    var dataSource: NVPhotoDataSource?
    var viewModel: NVPhotoViewModelProtocol?
    var albumModel: NVAlbumModel?
    
    
    //    MARK: ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureViewModel()
        self.setupUI()
        self.showIndicator()
        self.loadPhotos()
    }
}

//    MARK: General UI Setup Methods
extension NVPhotoViewController {
    private func setupUI() -> Void {
        self.title = "Photos"
        self.setupCollectionView()
        self.setupRefreshControl()
    }
    
    private func configureViewModel() {
        self.service = NVPhotoService()
        self.dataSource = NVPhotoDataSource()
        self.viewModel = NVPhotoViewModel(delegate: self, service: service, dataSource: dataSource)
    }
    
    private func setupCollectionView() -> Void {
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self.dataSource
        self.dataSource?.data.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async {
                self?.photoCollectionView.reloadData()
                self?.hideIndicator()
            }
        }
    }
    
    private func setupRefreshControl() -> Void {
        self.topPullToRefreshControl = UIRefreshControl()
        self.topPullToRefreshControl.tintColor = UIColor.black
        self.topPullToRefreshControl.addTarget(self, action: #selector(refreshControlValueChangedHandler), for: .valueChanged)
        self.photoCollectionView.alwaysBounceVertical = true
        self.photoCollectionView.addSubview(self.topPullToRefreshControl)
    }

    private func showIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.activityIndicator.startAnimating()
        }
    }

    private func hideIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.stopRefreshControl()
        }
    }
}

//    MARK: Data Methods
extension NVPhotoViewController {
    private func loadPhotos() -> Void {
        self.viewModel?.fetchPhotos(for: albumModel)
    }
}

//    MARK: Refresh Control Methods
extension NVPhotoViewController {
    @objc
    private func refreshControlValueChangedHandler() {
        self.topPullToRefreshControl?.beginRefreshing()
        self.loadPhotos()
    }
    
    private func stopRefreshControl() {
        if let refreshControl = self.topPullToRefreshControl, refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

//MARK: - NVPhotoViewControllerDelegate Methods
extension NVPhotoViewController: NVPhotoViewControllerDelegate {
    func fetchPhotosDidSucceed() {
        
    }
    
    func fetchPhotosDidFailedWith(_ error: NVError?) {
        DispatchQueue.main.async {
            self.hideIndicator()
            UIAlertController.showAlertWithOkButton(controller: self, strMessage: "Unable to fetch Albums", completion: nil)
        }
    }
}

//    MARK: UICollectionViewDelegateFlowLayout method
extension NVPhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 3
        return CGSize(width: width, height: width)
    }
}
