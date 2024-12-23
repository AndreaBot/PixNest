//
//  Protocols.swift
//  PixNest
//
//  Created by Andrea Bottino on 12/11/24.
//

import Foundation

protocol URLSessionProvider {
    func data(from: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProvider {}
