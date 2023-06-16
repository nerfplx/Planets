import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var presenter: AuthPresenter
    @Environment (\.dismiss) var dismiss
    
    private enum Constants {
        static let cornerRadiusTextField = CGFloat(12)
    }
    private enum Constraits {
        static let paddingTextField = CGFloat(8)
        static let paddindHorizontalTextField = CGFloat(20)
    }
    
    var body: some View {
        VStack (spacing: 20) {
            Text(presenter.isAuth ? "Authorization" : "Registration")
                .padding(presenter.isAuth ? 16 : 24)
                .padding(.horizontal, 40)
                .font(.title2.bold())
                .background(LinearGradient(colors: [Color("DarkBlue"), .clear], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(presenter.isAuth ? 40 : 60)
                .foregroundColor(.orange)
            
            VStack {
                TextField("", text: $presenter.email, prompt: Text("Email").foregroundColor(.gray.opacity(0.5)))
                    .padding()
                    .background(.white)
                    .cornerRadius(Constants.cornerRadiusTextField)
                    .padding(Constraits.paddingTextField)
                    .padding(.horizontal, Constraits.paddindHorizontalTextField)
                    .foregroundColor(.black)
                
                SecureField("", text: $presenter.password, prompt: Text("Password").foregroundColor(.gray.opacity(0.5)))
                    .padding()
                    .background(.white)
                    .cornerRadius(Constants.cornerRadiusTextField)
                    .padding(Constraits.paddingTextField)
                    .padding(.horizontal, Constraits.paddindHorizontalTextField)
                    .foregroundColor(.black)
                
                if !presenter.isAuth {
                    SecureField("", text: $presenter.confirmPassword, prompt: Text("Сonfirm the password").foregroundColor(.gray.opacity(0.5)))
                        .padding()
                        .background(.white)
                        .cornerRadius(Constants.cornerRadiusTextField)
                        .padding(Constraits.paddingTextField)
                        .padding(.horizontal, Constraits.paddindHorizontalTextField)
                        .foregroundColor(.black)
                    
                    TextField("", text: $presenter.name, prompt: Text("Your name").foregroundColor(.gray.opacity(0.5)))
                        .padding()
                        .background(.white)
                        .cornerRadius(Constants.cornerRadiusTextField)
                        .padding(Constraits.paddingTextField)
                        .padding(.horizontal, Constraits.paddindHorizontalTextField)
                        .foregroundColor(.black)
                    
                    TextField("", text: $presenter.phoneNumber, prompt: Text("+7 (000) 000-0000").foregroundColor(.gray.opacity(0.5)))
                        .onChange(of: presenter.phoneNumber) { newValue in
                            presenter.phoneNumber = format(with: "+# (###) ###-####", phone: newValue)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(Constants.cornerRadiusTextField)
                        .padding(Constraits.paddingTextField)
                        .padding(.horizontal, Constraits.paddindHorizontalTextField)
                        .foregroundColor(.black)
                        .keyboardType(.numberPad)
                }
                
                Button {
                    if presenter.isAuth {
                        presenter.loginUser {
                            dismiss()
                        }
                    } else {
                        presenter.registerUser {
                            dismiss()
                        }
                    }
                } label: {
                    Text (presenter.isAuth ? "Login" : "Create")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(Constants.cornerRadiusTextField)
                        .padding(Constraits.paddingTextField)
                        .padding(.horizontal, Constraits.paddindHorizontalTextField)
                        .font(.title2.bold())
                        .foregroundColor(.orange)
                }
                
                Button {
                    presenter.isAuth.toggle()
                } label: {
                    Text (presenter.isAuth ? "Not being with us?" : "Back to authorization")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(Constants.cornerRadiusTextField)
                        .padding(Constraits.paddingTextField)
                        .padding(.horizontal, Constraits.paddindHorizontalTextField)
                        .font(.title3.bold())
                        .foregroundColor(.orange)
                }
            }
            .padding()
            .padding(.top, 15)
            .background(LinearGradient(colors: [Color("DarkBlue"), .clear], startPoint: .leading, endPoint: .trailing))
            .cornerRadius(25)
            .padding(presenter.isAuth ? 30 : 12)
            .alert(item: $presenter.alert) { message in
                Alert(title: Text(message.rawValue), dismissButton: .default(Text("OK")))
            }
            .onTapGesture {
                dismissKeyboard()
            }
            
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("authBackground")
                    .resizable()
                    .blur(radius: presenter.isAuth ? 0 : 6)
            )
            .ignoresSafeArea()
            .animation(Animation.easeOut(duration: 0.3), value: presenter.isAuth)
    }
}

private extension AuthView {
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func format(with mask: String = "+# (###) ###-##-##", phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "#" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
