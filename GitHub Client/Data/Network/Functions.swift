//
//  Functions.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

func printIfDebug(_ string: String) {
    #if DEBUG
    print(string)
    #endif
}
