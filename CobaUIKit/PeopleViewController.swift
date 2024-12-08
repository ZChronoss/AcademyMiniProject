//
//  ViewController.swift
//  CobaUIKit
//
//  Created by Renaldi Antonio on 12/08/24.
//
import UIKit
import SafariServices

class PeopleViewController: UIViewController {
    
    private let vm = PeopleViewModel()
    
    private lazy var cv: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 130)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: "PersonCollectionViewCell")
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Haai")
        
        setup()
        vm.delegate = self
        vm.getUser()
    }
}

extension PeopleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = vm.people[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as! PersonCollectionViewCell
        cell.delegate = self
        cell.item = item
        return cell
    }
}

extension PeopleViewController: PeopleViewModelDelegate{
    func didFinish() {
        cv.reloadData()
    }
    
    func didFail(error: any Error) {
        print(error)
    }
}

extension PeopleViewController: PersonCollectionViewCellDelegate {
    func didTapSubScribe() {
        let url = URL(string: "https://www.youtube.com/watch?v=sZpTpBb2KB0")!
        let vc = SFSafariViewController(url: url)
        
        vc.modalPresentationStyle = .formSheet
        
        self.present(vc, animated: true)
    }
}

private extension PeopleViewController {
    func setup(){
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "People"
        
        self.view.backgroundColor = .white
        self.view.addSubview(cv)
        
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: view.topAnchor),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
