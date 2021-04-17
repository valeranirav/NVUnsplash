//
//  NVAlbumViewController.swift
//  NVUnsplash
//
//  Created by Nirav Valera on 01/04/21.
//

import UIKit

class NVAlbumViewController: UIViewController {
    @IBOutlet weak var albumTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var topPullToRefreshControl:UIRefreshControl!
    
    var service: NVAlbumServiceProtocol?
    var dataSource: NVAlbumDataSource?
    var viewModel: NVAlbumViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.configureViewModel()
        self.setupUI()
        self.showIndicator()
        self.loadAlbums()
    }
}

//    MARK: General UI Setup Methods
extension NVAlbumViewController {
    private func setupUI() -> Void {
        self.title = "Albums"
        self.setupTableView()
        self.setupSearchBar()
        self.setupRefreshControl()
    }
    
    private func setupTableView() {
        self.albumTableView.estimatedRowHeight = 50
        self.albumTableView.rowHeight = UITableView.automaticDimension
        self.albumTableView.dataSource = self.dataSource
        self.dataSource?.data.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async {
                self?.albumTableView.reloadData()
                self?.hideIndicator()
            }
        }
    }
    
    private func setupSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.searchTextField.clearButtonMode = .never
    }
    
    private func configureViewModel() {
        self.service = NVAlbumService()
        self.dataSource = NVAlbumDataSource()
        self.viewModel = NVAlbumViewModel(delegate: self, service: service ,dataSource: dataSource)
    }
    
    private func setupRefreshControl() -> Void {
        self.topPullToRefreshControl = UIRefreshControl()
        self.topPullToRefreshControl.tintColor = UIColor.black
        self.topPullToRefreshControl.addTarget(self, action: #selector(refreshControlValueChangedHandler), for: .valueChanged)
        self.albumTableView.alwaysBounceVertical = true
        self.albumTableView.addSubview(self.topPullToRefreshControl)
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

//    MARK: Refresh Control Methods
extension NVAlbumViewController {
    @objc
    private func refreshControlValueChangedHandler() {
        self.topPullToRefreshControl?.beginRefreshing()
        searchBar.searchTextField.text = ""
        searchBar.resignFirstResponder()
        self.loadAlbums()
    }
    
    private func stopRefreshControl() {
        if let refreshControl = self.topPullToRefreshControl, refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

//    MARK: Data Methods
extension NVAlbumViewController {
    private func loadAlbums(with albumTitle: String? = nil) -> Void {
        self.viewModel?.fetchAlbums(with: albumTitle)
    }
}

//MARK: - NVAlbumViewControllerProtocol Methods
extension NVAlbumViewController: NVAlbumViewControllerDelegate {
    func fetchAlbumsDidSucceed() {
        
    }
    
    func fetchAlbumsDidFailedWith(_ error: NVError?) {
        DispatchQueue.main.async {
            self.hideIndicator()
            UIAlertController.showAlertWithOkButton(controller: self, strMessage: "Unable to fetch Albums", completion: nil)
        }
    }    
}

//    MARK: Navigation Mwthods
extension NVAlbumViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == NVSegueIdentifier.showPhotos {
            self.performSegueForShowPhotoDetails(segue: segue)
        }
    }
    
    private func performSegueForShowPhotoDetails(segue :UIStoryboardSegue) {
        
        guard let indexPath = self.albumTableView.indexPathForSelectedRow else {
            fatalError("indexPath not found")
        }
        
        let albumModel = self.viewModel?.album(at: indexPath.row)
        let photoVC = segue.destination as! NVPhotoViewController
        photoVC.albumModel = albumModel
    }
}


//    MARK: UISearchBarDelegate Mwthods
extension NVAlbumViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.loadAlbums(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
