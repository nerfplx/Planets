import Foundation

protocol ModalDetailViewProtocol: AnyObject {
    func dismissView()
}

class ModalDetailPresenter {
    weak var view: ModalDetailViewProtocol?
    
    func closeButtonTapped() {
        view?.dismissView()
    }
}
