import Foundation

final class AuthPresenter: ObservableObject {
    
    @Published var isAuth = true
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isShowAlert = false
    @Published var alert: AlertMessage?
    @Published var name = ""
    @Published var phoneNumber = ""
    
    enum AlertMessage: String, Identifiable {
        var id: String { rawValue }
        
        case registrationSuccessful = "Регистрация прошла успешно"
        case incorrectLoginOrPassword = "Неверно введен логин или пароль"
        case passwordMismatch = "Пароли не совпадают"
        case registrationError = "Введен некорректные данные, либо пользователь с таким адресом уже существует"
        case fieldsAreEmpty = "Все поля обязательны к заполнению"
    }
    
    func loginUser(dismiss: @escaping () -> Void) {
        AuthService.shared.loginUser(email: self.email,
                                     password: self.password) { result in
            switch result {
            case.success(_):
                dismiss()
            case .failure(_):
                self.alert = .incorrectLoginOrPassword
                self.isShowAlert.toggle()
            }
        }
    }
    
    func registerUser(dismiss: @escaping () -> Void) {
        guard password == confirmPassword else {
            self.alert = .passwordMismatch
            self.isShowAlert.toggle()
            return
        }
        AuthService.shared.registerUser(email: self.email,
                                        password: self.password,
                                        name: self.name,
                                        phone: self.phoneNumber) { result in
            switch result {
            case .success(_):
                self.alert = .registrationSuccessful
                self.isShowAlert.toggle()
                self.email = ""
                self.password = ""
                self.confirmPassword = ""
                self.name = ""
                self.phoneNumber = ""
                self.isAuth.toggle()
                
            case .failure(_):
                self.alert = .registrationError
                self.isShowAlert.toggle()
            }
        }
    }
}
