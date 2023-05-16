import UIKit



class CollectionView: UIView {
    
    private var cells: [CollectionCellModel] = CollectionCellModel().loadItemCells()
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
    var completionHandler: ((CollectionCellModel?) -> Void)?
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CollectionView {
    
    private enum Constants {
        static let itemPerRow: CGFloat = 2
        static let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func setupUI() {
        self.configureCollectionLayout()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func configureCollectionLayout() {
        self.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension CollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionCellModel().loadItemCells().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell {
            itemCell.cell = CollectionCellModel().loadItemCells()[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
}

extension CollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailView = DetailView()
        var item = detailView.cell
        item = CollectionCellModel().loadItemCells()[indexPath.row]
        self.completionHandler?(item)
    }
}

extension CollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.sectionInsets.right * (Constants.itemPerRow + 1)
        let availableWidth = frame.width - paddingSpace
        let widtherItem = availableWidth / Constants.itemPerRow
        
        return CGSize(width: widtherItem, height: widtherItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }
}
