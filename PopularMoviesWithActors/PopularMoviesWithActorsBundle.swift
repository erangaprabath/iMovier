//
//  PopularMoviesWithActorsBundle.swift
//  PopularMoviesWithActors
//
//  Created by Eranga Prabath on 2024-09-27.
//

import WidgetKit
import SwiftUI

@main
struct PopularMoviesWithActorsBundle: WidgetBundle {

    var body: some Widget {
        PopularMoviesWithActors()
           
        PopularMoviesWithActorsControl()
        PopularMoviesWithActorsLiveActivity()
    }
}
