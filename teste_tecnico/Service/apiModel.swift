//
//  apiModel.swift
//  teste_tecnico
//
//  Created by Maria Tupich on 14/04/22.
//

import Foundation

// MARK: - MainStruct
struct MainStruct: Codable {
    let status: Int
    let object: [Object]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case object = "Object"
    }
}

// MARK: - Object
struct Object: Codable {
    let player: Player

    enum CodingKeys: String, CodingKey {
        case player = "Player"
    }
}

// MARK: - Player
struct Player: Codable {
    let img: String
    let name: String
    let percentual: Double
    let pos, country: String
    let barras: Barras

    enum CodingKeys: String, CodingKey {
        case img, name, percentual, pos, country
        case barras = "Barras"
    }
}

// MARK: - Barras
struct Barras: Codable {
    let copasDoMundoVencidas, copasDoMundoDisputadas: CopasDoMundoDas

    enum CodingKeys: String, CodingKey {
        case copasDoMundoVencidas = "Copas_do_Mundo_Vencidas"
        case copasDoMundoDisputadas = "Copas_do_Mundo_Disputadas"
    }
}

// MARK: - CopasDoMundoDas
struct CopasDoMundoDas: Codable {
    let max, pla, pos: Float
}
