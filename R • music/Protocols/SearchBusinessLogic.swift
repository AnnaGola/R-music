//
//  SearchBusinessLogic.swift
//  R • music
//
//  Created by anna on 24.07.2022.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}
