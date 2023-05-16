import Foundation
import UIKit

struct CollectionCellModel {
    var image: UIImage?
    var name: String?
}

var itemCells: [CollectionCellModel] = [
    CollectionCellModel(image: UIImage(named: "bb_barberry_shok") ?? UIImage(), name: "Burn Black - Barberry Shock"),
    CollectionCellModel(image: UIImage(named: "bonche_cherry") ?? UIImage(), name: "Bonche - Cherry"),
    CollectionCellModel(image: UIImage(named: "ds_cyber_kiwi") ?? UIImage(), name: "Darkside - Cyber Kiwi"),
    CollectionCellModel(image: UIImage(named: "ds_darksupra") ?? UIImage(), name: "Darkside - DarkSupra"),
    CollectionCellModel(image: UIImage(named: "ds_goal") ?? UIImage(), name: "Darkside - GOAL"),
    CollectionCellModel(image: UIImage(named: "ds_sweet_comet") ?? UIImage(), name: "Darkside - Sweet Comet"),
    CollectionCellModel(image: UIImage(named: "ds_tropic_ray") ?? UIImage(), name: "Darkside - Tropic Ray"),
    CollectionCellModel(image: UIImage(named: "duft_pistachio_cream") ?? UIImage(), name: "Duft - Pistachio Cream"),
    CollectionCellModel(image: UIImage(named: "satyr_platinum") ?? UIImage(), name: "Satyr - Triple Cask"),
    CollectionCellModel(image: UIImage(named: "satyr_sigara") ?? UIImage(), name: "Satyr - World Trip")
]
