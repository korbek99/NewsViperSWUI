//
//  NewsRouter.swift
//  NewsViperSWUI
//
//  Created by Jose Preatorian on 02-02-26.
//

import Foundation

import SwiftUI

class NewsRouter {
    
    static func createModule() -> some View {
       
        let service = WebServicesNews()

        let interactor = NewsInteractor(service: service)

        let presenter = NewsPresenter()

        presenter.interactor = interactor

        interactor.presenter = presenter

        return PopularNewsView(presenter: presenter)
    }
}
