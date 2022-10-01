//
//  ProductsServices.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import Foundation
import Combine

class ItmesService {
    static var shared: ItmesService = ItmesService()
    func getItems() -> AnyPublisher<ItemsReponse, Error> {
        let path: String = "5c138271-d8dd-4112-8fb4-3adb1b7f689e"
        return ServiceManager(baseUrl: ApiConstants.baseUrl).get(path, params: [:])
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
