//
//  AlbumsViewController.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

protocol AlbumsViewControllerProtocol: BaseViewControllerProtocol {
    var presenter: AlbumsPresenterProtocol? { get set }
    
    func show(albums: [AlbumsViewModel])
}

final class AlbumsViewController: BaseViewController {
    var presenter: AlbumsPresenterProtocol?
    
    @IBOutlet private weak var tableView: UITableView!
    private var data: [AlbumsViewModel] = []
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        presenter?.onViewDidLoad()
    }
}

extension AlbumsViewController: AlbumsViewControllerProtocol {
    func show(albums: [AlbumsViewModel]) {
        self.data = albums
        tableView.reloadData()
    }
}

private extension AlbumsViewController {
    // MARK: Private methods
    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
}

extension AlbumsViewController: UITableViewDataSource {
    // MARK: TableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AlbumsViewController: UITableViewDelegate {
    // MARK: TableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onSelectAlbum(with: indexPath.row)
    }
}
