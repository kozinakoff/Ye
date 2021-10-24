//
//  YeError.swift
//  Ye
//
//  Created by ANDREY VORONTSOV on 24.10.2021.
//

import Foundation

enum YeError: String, Error {
    
    case NotFound = "Quotes not found."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again"
}
