//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var userNameError: String = ""
    @Published var password: String = ""
    @Published var passwordError: String = ""
    @Published var isValid: Bool = false
   
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        userNamePublisher
            .receive(on: RunLoop.main)
            .map { userNameValid in
                userNameValid ? "" : "User name has to be at least 5 chars long"
            }
            .assign(to: \.userNameError, on: self)
            .store(in: &cancellables)
        
        
        passwordPublisher
            .receive(on: RunLoop.main)
            .map { passwordValid in
                passwordValid ? "" : "The password has to be at least 5 chars long"
            }
            .assign(to: \.passwordError, on: self)
            .store(in: &cancellables)
        
        isValidPublisher
            .map { valid in
                print("Valid: \(valid)")
                return valid
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
    }
}

extension ContentViewModel {
    
    var isValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(userNamePublisher, passwordPublisher)
            .map { userNameValid, passwordValid in
                userNameValid && passwordValid
            }.eraseToAnyPublisher()
    }
    
    var userNamePublisher: AnyPublisher<Bool, Never> {
        $userName
            //A publisher that publishes events only after a specified time elapses.
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                print("userName \($0)")
                return $0.count > 5
            }
            .eraseToAnyPublisher()
    }
    
    var passwordPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                print("password \($0)")
                return $0.count > 5
            }
            .eraseToAnyPublisher()
    }
}

struct ContentView: View {

    @ObservedObject var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            TextField("Username", text: $vm.userName)
            Text(vm.userNameError)
                .foregroundColor(.red)
                .font(.caption2)
                .padding(.bottom, 10)
            
            SecureField("Password", text: $vm.password)
                
            Text(vm.passwordError)
                .foregroundColor(.red)
                .font(.caption2)
                .padding(.bottom, 10)
            
            Button {
                print("Registering")
            } label: {
                Text("Register")
                    .foregroundColor(.white)
            }
            .padding()
            .background(vm.isValid ? .green : .red)
            .cornerRadius(8)
            .disabled(!vm.isValid)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
