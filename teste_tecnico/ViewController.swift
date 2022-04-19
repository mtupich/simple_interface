//
//  ViewController.swift
//  teste_tecnico
//
//  Created by Maria Tupich on 14/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    var mainStructOfApi: MainStruct?
    
    lazy var roundedImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .yellow
        image.contentMode = .scaleAspectFill
        image.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28.0)
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    lazy var roundedBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        view.backgroundColor = UIColor(white: 1, alpha: 0.7)
        view.layer.cornerRadius = view.frame.size.width/2
        view.addSubview(numberOnThebackgroundLabel)
        return view
    }()
    
    lazy var numberOnThebackgroundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textColor = .purple
        return label
    }()
    
    lazy var worldCupsWonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Copas do Mundo Vencidas"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        return label
    }()
    
    lazy var worldCupsMatchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Copas do Mundo Disputadas"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        return label
    }()
    
    lazy var progressWonBar: ProgressView = {
        let bar = ProgressView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    lazy var progressMatchBar: ProgressView = {
        let bar = ProgressView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    lazy var whiteBorderWonLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 15
        view.addSubview(progressWonBar)
        view.addSubview(plaWonLabel)
        return view
    }()
    
    lazy var whiteBorderMatchLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 15
        view.addSubview(progressMatchBar)
        view.addSubview(plaMatchLabel)
        return view
    }()
    
    lazy var plaWonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var posWonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    
    lazy var plaMatchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var posMatchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackground()
        addSubviews()
        setLayoutConstraints()
        self.roundedImageView.downloaded(from: "http://sportsmatch.com.br/teste/img.jpg")
        loadData()
    }
    
    func loadData() {
        
        var maxValueBar: Float = 0.0
        var currentValueBar: Float = 0.0
        
        // cria um path
        guard let path = Bundle.main.path(forResource: "jsonContent", ofType: "json") else { return print("path not found") }
        // converte para url
        let url = URL(fileURLWithPath: path)
        
        do {
            // converte para dados
            let data = try Data(contentsOf: url)
            // decodifica os dados
            mainStructOfApi = try JSONDecoder().decode(MainStruct.self, from: data)
            self.titleLabel.text = mainStructOfApi?.object[0].player.name
            self.countryLabel.text = mainStructOfApi?.object[0].player.country
            self.positionLabel.text = mainStructOfApi?.object[0].player.pos
            self.numberOnThebackgroundLabel.text = String(format: "%.3f", (mainStructOfApi?.object[0].player.percentual)!)
            maxValueBar = mainStructOfApi?.object[0].player.barras.copasDoMundoVencidas.max ?? 0.0
            currentValueBar = mainStructOfApi?.object[0].player.barras.copasDoMundoVencidas.pla ?? 0.0
            self.progressWonBar.progressBar.progress = currentValueBar / maxValueBar
            self.plaWonLabel.text = String(currentValueBar)
            self.posWonLabel.text = String(format: "%.0f", mainStructOfApi?.object[0].player.barras.copasDoMundoVencidas.pos ?? 0.0) + "°"
            self.progressMatchBar.progressBar.progress = (mainStructOfApi?.object[0].player.barras.copasDoMundoDisputadas.pla ?? 0.0) / (mainStructOfApi?.object[0].player.barras.copasDoMundoDisputadas.max ?? 0.0)
            self.plaMatchLabel.text = String(mainStructOfApi?.object[0].player.barras.copasDoMundoDisputadas.pla ?? 0.0)
            self.posMatchLabel.text = String(format: "%.0f", mainStructOfApi?.object[0].player.barras.copasDoMundoDisputadas.pos ?? 0.0) + "°"
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func setBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func addSubviews() {
        view.addSubview(roundedImageView)
        view.addSubview(titleLabel)
        view.addSubview(countryLabel)
        view.addSubview(positionLabel)
        view.addSubview(roundedBackground)
        view.addSubview(worldCupsWonLabel)
        view.addSubview(whiteBorderWonLineView)
        view.addSubview(posWonLabel)
        view.addSubview(worldCupsMatchLabel)
        view.addSubview(whiteBorderMatchLineView)
        view.addSubview(posMatchLabel)
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            
            roundedImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            roundedImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            roundedImageView.heightAnchor.constraint(equalToConstant: 150),
            roundedImageView.widthAnchor.constraint(equalToConstant: 150),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.roundedImageView.bottomAnchor, constant: 24),
            
            countryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            countryLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24),
            
            positionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            positionLabel.topAnchor.constraint(equalTo: self.countryLabel.bottomAnchor, constant: 24),
            
            roundedBackground.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            roundedBackground.topAnchor.constraint(equalTo: self.positionLabel.bottomAnchor, constant: 24),
            roundedBackground.heightAnchor.constraint(equalToConstant: 100),
            roundedBackground.widthAnchor.constraint(equalToConstant: 100),
            
            numberOnThebackgroundLabel.centerXAnchor.constraint(equalTo: self.roundedBackground.centerXAnchor),
            numberOnThebackgroundLabel.centerYAnchor.constraint(equalTo: self.roundedBackground.centerYAnchor),
            
            worldCupsWonLabel.topAnchor.constraint(equalTo: self.roundedBackground.bottomAnchor, constant: 24),
            worldCupsWonLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            whiteBorderWonLineView.topAnchor.constraint(equalTo: self.worldCupsWonLabel.bottomAnchor, constant: 5),
            whiteBorderWonLineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            whiteBorderWonLineView.heightAnchor.constraint(equalToConstant: 30),
            whiteBorderWonLineView.widthAnchor.constraint(equalToConstant: 300),
            
            progressWonBar.topAnchor.constraint(equalTo: self.whiteBorderWonLineView.topAnchor),
            progressWonBar.leadingAnchor.constraint(equalTo: self.whiteBorderWonLineView.leadingAnchor),
            progressWonBar.trailingAnchor.constraint(equalTo: self.whiteBorderWonLineView.trailingAnchor),
            progressWonBar.bottomAnchor.constraint(equalTo: self.whiteBorderWonLineView.bottomAnchor),
            
            posWonLabel.topAnchor.constraint(equalTo: self.worldCupsWonLabel.bottomAnchor, constant: -4),
            posWonLabel.leadingAnchor.constraint(equalTo: self.whiteBorderWonLineView.trailingAnchor, constant: 10),
            posWonLabel.heightAnchor.constraint(equalToConstant: 50),
            
            plaWonLabel.topAnchor.constraint(equalTo: self.progressWonBar.topAnchor),
            plaWonLabel.leadingAnchor.constraint(equalTo: self.progressWonBar.leadingAnchor, constant: 20),
            plaWonLabel.bottomAnchor.constraint(equalTo: self.progressWonBar.bottomAnchor),
            
            worldCupsMatchLabel.topAnchor.constraint(equalTo: self.whiteBorderWonLineView.bottomAnchor, constant: 24),
            worldCupsMatchLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            whiteBorderMatchLineView.topAnchor.constraint(equalTo: self.worldCupsMatchLabel.bottomAnchor, constant: 5),
            whiteBorderMatchLineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            whiteBorderMatchLineView.heightAnchor.constraint(equalToConstant: 30),
            whiteBorderMatchLineView.widthAnchor.constraint(equalToConstant: 300),
            
            progressMatchBar.topAnchor.constraint(equalTo: self.whiteBorderMatchLineView.topAnchor),
            progressMatchBar.leadingAnchor.constraint(equalTo: self.whiteBorderMatchLineView.leadingAnchor),
            progressMatchBar.trailingAnchor.constraint(equalTo: self.whiteBorderMatchLineView.trailingAnchor),
            progressMatchBar.bottomAnchor.constraint(equalTo: self.whiteBorderMatchLineView.bottomAnchor),
            
            posMatchLabel.topAnchor.constraint(equalTo: self.worldCupsMatchLabel.bottomAnchor, constant: -4),
            posMatchLabel.leadingAnchor.constraint(equalTo: self.whiteBorderMatchLineView.trailingAnchor, constant: 10),
            posMatchLabel.heightAnchor.constraint(equalToConstant: 50),

            plaMatchLabel.topAnchor.constraint(equalTo: self.progressMatchBar.topAnchor),
            plaMatchLabel.leadingAnchor.constraint(equalTo: self.progressMatchBar.leadingAnchor, constant: 20),
            plaMatchLabel.bottomAnchor.constraint(equalTo: self.progressMatchBar.bottomAnchor),
        ])
    }
    
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
