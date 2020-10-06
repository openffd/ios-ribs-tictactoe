//
// Written by Feb De La Cruz on 10/7/20.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol LoggedOutPresentableListener: AnyObject {
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    private var player1Field: UITextField?
    private var player2Field: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let playerFields = buildPlayerFields()
        buildLoginButton(withPlayer1Field: playerFields.player1Field, player2Field: playerFields.player2Field)
    }
    
    private func buildPlayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
        let player1Field = UITextField()
        self.player1Field = player1Field
        player1Field.borderStyle = .line
        view.addSubview(player1Field)
        player1Field.placeholder = "Player 1 name"
        player1Field.snp.makeConstraints { constraintMaker in
            constraintMaker.top.equalTo(self.view).offset(100)
            constraintMaker.leading.trailing.equalTo(self.view).inset(40)
            constraintMaker.height.equalTo(40)
        }
        
        let player2Field = UITextField()
        self.player2Field = player2Field
        player2Field.borderStyle = .line
        view.addSubview(player2Field)
        player2Field.placeholder = "Player 2 name"
        player2Field.snp.makeConstraints { constraintMaker in
            constraintMaker.top.equalTo(player1Field.snp.bottom).offset(20)
            constraintMaker.left.right.height.equalTo(player1Field)
        }
        
        return (player1Field, player2Field)
    }
    
    private func buildLoginButton(withPlayer1Field player1Field: UITextField, player2Field: UITextField) {
        let loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { constraintMaker in
            constraintMaker.top.equalTo(player2Field.snp.bottom).offset(20)
            constraintMaker.left.right.height.equalTo(player2Field)
        }
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc private func didTapLoginButton() {
        listener?.login(withPlayer1Name: player1Field?.text, player2Name: player2Field?.text)
    }
}
