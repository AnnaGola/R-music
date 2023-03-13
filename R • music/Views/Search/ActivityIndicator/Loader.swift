import UIKit

class Loader: UIView {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Creating indicator
    
    private var loading: UILabel = {
        let loading = UILabel()
        loading.font = UIFont.systemFont(ofSize: 14)
        loading.textAlignment = .center
        loading.textColor = #colorLiteral(red: 0.7450386882, green: 0.567944169, blue: 0.4872100949, alpha: 1)
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = #colorLiteral(red: 0.7450386882, green: 0.567944169, blue: 0.4872100949, alpha: 1)
        return activityIndicator
    }()
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        addSubview(activityIndicator)
        activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 320).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        addSubview(loading)
        loading.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8).isActive = true
        loading.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
        loading.text = "Loading..."
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        loading.text = ""
    }
}
