import Foundation
import UIKit

protocol ItemsModelProtocol: AnyObject {
    func fetchItems(completion: @escaping ([Item]) -> Void)
}

class ItemsModel: ItemsModelProtocol {
    func fetchItems(completion: @escaping ([Item]) -> Void) {
        let items = [
            Item(image: UIImage(named: "bb_barberry_shok") ?? UIImage(), name: "Burn Black - Barberry Shock"),
            Item(image: UIImage(named: "bonche_cherry") ?? UIImage(), name: "Bonche - Cherry"),
            Item(image: UIImage(named: "ds_cyber_kiwi") ?? UIImage(), name: "Darkside - Cyber Kiwi"),
            Item(image: UIImage(named: "ds_darksupra") ?? UIImage(), name: "Darkside - DarkSupra"),
            Item(image: UIImage(named: "ds_goal") ?? UIImage(), name: "Darkside - GOAL"),
            Item(image: UIImage(named: "ds_sweet_comet") ?? UIImage(), name: "Darkside - Sweet Comet"),
            Item(image: UIImage(named: "ds_tropic_ray") ?? UIImage(), name: "Darkside - Tropic Ray"),
            Item(image: UIImage(named: "duft_pistachio_cream") ?? UIImage(), name: "Duft - Pistachio Cream"),
            Item(image: UIImage(named: "satyr_platinum") ?? UIImage(), name: "Satyr - Triple Cask"),
            Item(image: UIImage(named: "satyr_sigara") ?? UIImage(), name: "Satyr - World Trip")
        ]
        completion(items)
    }
}
