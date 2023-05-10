import UIKit
import SnapKit

class CollectionViewController: UIViewController {
    
    private let navigationBarItem = "Favourite hookah flavors"
    
    private enum Constants {
        static let itemPerRow: CGFloat = 2
        static let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private var cells: [CollectionCellModel] = itemCells
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

private extension CollectionViewController {
    func setupUI () {
        self.view.addSubview(collectionView)
        self.configureCollectionLayout()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.configureNavigationBarItem()
    }
    
    func configureNavigationBarItem () {
        self.navigationController?.navigationBar.topItem?.title = navigationBarItem
        
    }
    
    func configureCollectionLayout() {
        self.view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell {
            itemCell.cell = itemCells[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.cell = itemCells[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.sectionInsets.right * (Constants.itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widtherItem = availableWidth / Constants.itemPerRow
        
        return CGSize(width: widtherItem, height: widtherItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }
}
