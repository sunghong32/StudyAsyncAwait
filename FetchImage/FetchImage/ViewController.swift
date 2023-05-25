//
//  ViewController.swift
//  FetchImage
//
//  Created by 민성홍 on 2023/05/25.
//

import UIKit

class ViewController: UIViewController {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "questionmark.app")

        return imageView
    }()

    let newImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Shuffle", for: .normal)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapShuffle), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        Task {
            await fetchImage()
        }
    }

    func configureUI() {
        view.addSubview(imageView)
        view.addSubview(newImageButton)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),

            newImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            newImageButton.heightAnchor.constraint(equalToConstant: 75),
            newImageButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    @MainActor
    private func fetchImage() async {
        do {
            let image = try await APIService().fetchImage()
            imageView.image = image
        } catch {
            print(error.localizedDescription)
        }
    }

    @objc func didTapShuffle() {
        Task {
            await fetchImage()
        }
    }
}


