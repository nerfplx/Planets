import Foundation


protocol ModalDetailViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func dismissView()
}

class ModalDetailPresenter {
    weak var view: ModalDetailViewProtocol?
    
    func viewDidLoad() {
        view?.setTitle("Close")
    }
}

extension ModalDetailPresenter {
    func closeButtonTapped() {
        view?.dismissView()
    }
}
