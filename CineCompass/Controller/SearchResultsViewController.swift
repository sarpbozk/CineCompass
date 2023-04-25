//
//  SearchResultsViewController.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 25.04.2023.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let movies = [
        Movie(id: 157336, title: "Interstellar"),
        Movie(id: 000000, title: "BlahBlah"),
        Movie(id: 111111, title: "BlehBleh"),
        Movie(id: 222222, title: "BluhBluh"),
        Movie(id: 333333, title: "BlihBlih"),
        Movie(id: 157336, title: "Interstellar"),
        Movie(id: 000000, title: "BlahBlah"),
        Movie(id: 111111, title: "BlehBleh"),
        Movie(id: 222222, title: "BluhBluh"),
        Movie(id: 333333, title: "BlihBlih"),
        Movie(id: 157336, title: "Interstellar"),
        Movie(id: 000000, title: "BlahBlah"),
        Movie(id: 111111, title: "BlehBleh"),
        Movie(id: 222222, title: "BluhBluh"),
        Movie(id: 333333, title: "BlihBlih"),
        Movie(id: 157336, title: "Interstellar"),
        Movie(id: 000000, title: "BlahBlah"),
        Movie(id: 111111, title: "BlehBleh"),
        Movie(id: 222222, title: "BluhBluh"),
        Movie(id: 333333, title: "BlihBlih")
    ]
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)

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

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MovieCell
        cell.movieName.text = movies[indexPath.row].title
        return cell
    }
    
}
