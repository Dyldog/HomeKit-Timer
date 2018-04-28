//
//  SimpleListViewController.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 28/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit

class SimpleListPresenter<T>: NSObject {
    func modelItemSelected(_ modelItem: T) { }
}

class SimpleListViewController<T> : UITableViewController {
    var modelItems: [T] = []
    var cellInitializer: ((_ modelItem: T, _ cell: UITableViewCell) -> Void)?
    
    var presenter: SimpleListPresenter<T>?
    
    func initialize() { }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        initialize()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.numberOfLines = 0
        
        let modelItem = modelItems[indexPath.row]
        
        cellInitializer?(modelItem, cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelItem = modelItems[indexPath.row]
        presenter?.modelItemSelected(modelItem)
    }
    
    final func reloadData() {
        self.tableView.reloadData()
    }
}
