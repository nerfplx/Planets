import UIKit
import SnapKit
import SDWebImage

protocol PlanetDetailViewProtocol: AnyObject {
    func showPlanetDetails(with planet: PlanetModel)
    func showError(error: Error)
}

final class PlanetDetailView: UIView, UIScrollViewDelegate {
    private let planetLabel = UILabel()
    private let imageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let planetModel: PlanetModel
    private var scrollView: UIScrollView!
    
    private var diameterLabel = UILabel()
    private var massLabel = UILabel()
    private var sideralOrbitLabel = UILabel()
    private var sideralRotationTimeLabel = UILabel()
    private var gravityLabel = UILabel()
    private var avgTempCelsiusLabel = UILabel()
    
    private enum Constants {
        static let fontPlanetLabel = CGFloat(21)
        static let fontParametrsLabel = CGFloat(17)
    }
    
    private enum Constraits {
        static let leadingEqualToSuperview = CGFloat(10)
        static let topEqualToParametrs = CGFloat(5)
        static let topEqualToImage = CGFloat(20)
        static let bottomEqualToImage = CGFloat(-20)
        static let imageTopEqualToSuperview = CGFloat(150)
        static let heightEqualToSuperviewMultipliedBy = CGFloat(0.5)
    }
    
    init(frame: CGRect, planetModel: PlanetModel) {
        self.planetModel = planetModel
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: PlanetModel) {
        planetLabel.text = model.planet.title
        animateLabels()
        
        if let url = URL(string: model.planet.imageUrl) {
            imageView.sd_setImage(with: url, placeholderImage: nil, progress: { (receivedSize, expectedSize, _) in
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                }
            }) { (image, error, cacheType, url) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        if let details = planetModel.details {
            diameterLabel.text = "Radius: \(details.meanRadius) km"
            massLabel.text = "Mass: \(details.mass.massValue) x 10^\(details.mass.massExponent) kg"
            gravityLabel.text = "Gravity: \(details.gravity) m/s²"
            sideralOrbitLabel.text = "Length of year: \(details.sideralOrbit) earth days"
            sideralRotationTimeLabel.text = "Length of day: \(details.sideralRotationTime)"
            avgTempCelsiusLabel.text = "Tempretature: \(details.avgTempCelsius) °C"
        }
    }
}

private extension PlanetDetailView {
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(named: "DarkOrange")
        label.font = UIFont(name: "Overpass-SemiBold", size: Constants.fontParametrsLabel)
        addSubview(label)
        return label
    }
    
    func setupUI() {
        backgroundColor = .black
        configureImageView()
        configureActivityIndicator()
        configurePlanetLabel()
        configurePlanetsParameters()
    }
    
    func configurePlanetLabel() {
        addSubview(planetLabel)
        planetLabel.textColor = .orange
        planetLabel.textAlignment = .center
        planetLabel.font = UIFont(name: "Overpass-SemiBold", size: Constants.fontPlanetLabel)
        planetLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageView.snp.top).offset(Constraits.bottomEqualToImage)
        }
    }
    
    func configureActivityIndicator() {
        imageView.addSubview(activityIndicator)
        activityIndicator.color = .orange
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureImageView() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constraits.imageTopEqualToSuperview)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Constraits.heightEqualToSuperviewMultipliedBy)
        }
    }
    
    func configurePlanetsParameters() {
        diameterLabel = createLabel()
        diameterLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constraits.topEqualToImage)
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
        }
        
        massLabel = createLabel()
        massLabel.snp.makeConstraints { make in
            make.top.equalTo(diameterLabel.snp.bottom).offset(Constraits.topEqualToParametrs)
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
        }
        
        gravityLabel = createLabel()
        gravityLabel.snp.makeConstraints { make in
            make.top.equalTo(massLabel.snp.bottom).offset(Constraits.topEqualToParametrs)
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
        }
        
        sideralOrbitLabel = createLabel()
        sideralOrbitLabel.snp.makeConstraints { make in
            make.top.equalTo(gravityLabel.snp.bottom).offset(Constraits.topEqualToParametrs)
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
        }
        
        sideralRotationTimeLabel = createLabel()
        sideralRotationTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(sideralOrbitLabel.snp.bottom).offset(Constraits.topEqualToParametrs)
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
        }
        
        avgTempCelsiusLabel = createLabel()
        avgTempCelsiusLabel.snp.makeConstraints { make in
            make.top.equalTo(sideralRotationTimeLabel.snp.bottom).offset(Constraits.topEqualToParametrs)
            make.leading.equalToSuperview().offset(Constraits.leadingEqualToSuperview)
        }
    }
    
    func animateLabels() {
        let labels = [diameterLabel, massLabel, gravityLabel, sideralOrbitLabel, sideralRotationTimeLabel, avgTempCelsiusLabel]
        for (index, label) in labels.enumerated() {
            label.transform = CGAffineTransform(translationX: -self.bounds.width, y: 0)
            UIView.animate(withDuration: 0.7, delay: Double(index) * 0.1, options: .curveEaseOut, animations: {
                label.transform = .identity
            })
        }
    }
}
