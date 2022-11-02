//
//  LoginViewModel.swift
//  RxSwiftLogin
//
//  Created by VELJKO on 2.11.22..
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let usernameText = PublishSubject<String>()
    let passwordText = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable
            .combineLatest(usernameText.asObserver().startWith(""), passwordText.asObserver().startWith(""))
            .map({ usernameText, passwordText in
                return usernameText.count > 3 && passwordText.count > 3
            }).startWith(false)
    }
}
