enum AuthError: Error {
    case invalidName
    case invalidPassword
    case userDisabled
    case emailAlreadyInUse
    case invalidEmail
    case wrongPassword
    case userNotFound
    case accountExistsWithDifferentCredential
    case networkError
    case credentialAlreadyInUse
    case unknown
    
    private static let errorByCode: [Int: AuthError] = [
        17005: .userDisabled,
        17007: .emailAlreadyInUse,
        17008: .invalidEmail,
        17009: .wrongPassword,
        17011: .userNotFound,
        17012: .accountExistsWithDifferentCredential,
        17020: .networkError,
        17025: .credentialAlreadyInUse,
        17026: .invalidPassword
    ]
    
    var localizedDescription: String {
        switch self {
        case .invalidName:
            return "Invalid username. Try another one"
        case .invalidPassword:
            return "Invalid password. Try another one"
        case .userDisabled:
            return "User disabled"
        case .emailAlreadyInUse:
            return "Email is already in use. Choose another one"
        case .invalidEmail:
            return "Invalid email. Try another one"
        case .wrongPassword:
            return "Wrong Password. Try another one"
        case .userNotFound:
            return "User not found"
        case .accountExistsWithDifferentCredential:
            return "Something wrong has happend. We're fixing it"
        case .networkError:
            return "Something wrong has happend. We're fixing it"
        case .credentialAlreadyInUse:
            return "Something wrong has happend. We're fixing it"
        case .unknown:
            return "Something wrong has happend. We're fixing it"
        }
    }
    
    init(rawValue: Int) {
        self = AuthError.errorByCode[rawValue] ?? .unknown
    }
}
