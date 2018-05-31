//
//  PresenterProtocol.swift
//  SevenThousandOaks
//
//  Created by Richard Willis on 27/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug

protocol PresenterProtocol: FZPresenterProtocol {
	mutating func populateView(with oaksFelled: Int)
}
