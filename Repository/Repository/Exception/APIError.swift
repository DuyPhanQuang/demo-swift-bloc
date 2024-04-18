//
//  APIError.swift
//  Repository
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

public enum APIError: Error {
    case unknown
    case unauthorized
}

public enum UnauthorizedError: Error {
    case tokenExpired
}

