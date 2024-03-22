//
//  APIClient.swift
//  ArchitectureMVVM
//
//  Created by Raul Kevin Aliaga Shapiama on 3/22/24.
//

import Foundation

enum BackendError: String, Error {
    case invalidEmail = "El email es inválido"
    case invalidPassword = "El password es inválido"
    case invalidData = "Los datos son inválidos"
}


final class APIClient {
    func login(withEmail email: String, password: String) async throws -> User {
        // Simular pitcion HTTP y esperar 2 segundos
        
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
        return try simulateBackendLogic(email: email, password: password)
    }
}

func simulateBackendLogic(email: String, password: String) throws -> User{
    guard email == "swiftbeta.blog@gmail.com" else {
        print("El user no es SwiftBeta")
        throw BackendError.invalidEmail
    }
    
    guard password == "1234567890" else {
        print("El password no es 1234567890")
        throw BackendError.invalidPassword
    }
    print("Success!")
    
    return .init(name: "Swift Beta", token: "token_123456789", sessionStart: .now)
}
