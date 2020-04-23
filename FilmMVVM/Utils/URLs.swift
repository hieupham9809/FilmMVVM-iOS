//
//  URL.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation

struct URLs {
    // MARK: BASE URLs
    private static var APIBaseUrl = "https://api.themoviedb.org/3"
    public static var baseImageUrl = "https://image.tmdb.org/t/p/w185/"
    
    // MARK: GUEST
    public static var movieExploreUrl = APIBaseUrl + "/discover/movie"
    public static var movieDetailUrl = APIBaseUrl + "/movie"
    public static var movieSearchByTitleUrl = APIBaseUrl + "/search/movie"
    
    // MARK: AUTHENTICATION
    public static var createAuthenToken = APIBaseUrl + "/authentication/token/new"
    public static var createAuthenSession = APIBaseUrl + "/authentication/session/new"
    public static var validateAuthenToken = APIBaseUrl + "/authentication/token/validate_with_login"
    public static var deleteSession = APIBaseUrl + "/authentication/session"
    // MARK: ACCOUNT
    public static var getAccountInfo = APIBaseUrl + "/account"
    public static var getFavoriteMovieList = APIBaseUrl + "/account/{id}/favorite/movies"
    public static var markFavorite = APIBaseUrl + "/account/{id}/favorite"
}
