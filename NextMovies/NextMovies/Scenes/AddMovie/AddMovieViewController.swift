//
//  AddMovieViewController.swift
//  NextMovies
//
//  Created by Tiago Chaves on 16/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit
import CoreData

class AddMovieViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var rattingSlider: UISlider!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    var categories:[Category] = []
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        loadMovie()
    }
    
    private func loadMovie() {
        
        if let movie = self.movie {
            
            titleTextField.text = movie.title
            durationTextField.text = movie.duration
            rattingSlider.value = Float(movie.rating)
            summaryTextView.text = movie.summary
            
            if let imageData = movie.image, let image = UIImage(data: imageData) {
                posterImage.image = image
            }else{
                posterImage.image = nil
            }
            
            self.categories = Array(movie.categories ?? [])
        }else{
            
            titleTextField.text = ""
            durationTextField.text = ""
            rattingSlider.value = 2.5
            summaryTextView.text = ""

            posterImage.image = nil
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        let height = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).size.height
        
        self.scrollview.contentInset.bottom = height
        self.scrollview.scrollIndicatorInsets.bottom = height
        
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        self.scrollview.contentInset.bottom = 0
        self.scrollview.scrollIndicatorInsets.bottom = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func changeRatting(_ sender: Any) {
    
        
    }
    
    @IBAction func saveMovie(_ sender: Any) {
    
        if movie == nil{
            movie = Movie(context: CoreDataManager.sharedInstance.persistentContainer.viewContext)
        }
        
        movie?.title = titleTextField.text ?? ""
        movie?.duration = durationTextField.text ?? "1h"
        movie?.rating = Double(rattingSlider.value)
        movie?.summary = summaryTextView.text
        movie?.image = posterImage.image?.pngData()
        
        movie?.categories = Set(categories)
        
        CoreDataManager.sharedInstance.saveContext()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectImage(_ sender: Any) {
    
        let imageOptions = UIAlertController(title: "Poster do filme", message: "Escolha de onde vai pegar o poster", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (_) in
                
                self.selectPicture(source: .camera)
            }
            imageOptions.addAction(cameraAction)
        }
        
        let galleryAction = UIAlertAction(title: "Álbum de Fotos", style: .default) { (_) in
            
            self.selectPicture(source: .savedPhotosAlbum)
        }
        imageOptions.addAction(galleryAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style:.cancel)
        imageOptions.addAction(cancelAction)
        
        present(imageOptions, animated: true, completion: nil)
    }
    
    private func selectPicture(source:UIImagePickerController.SourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueAddMovieToCategories", let categoriesVC = segue.destination as? CategoriesTableViewController {
            
            categoriesVC.delegate   = self
            categoriesVC.categoriesToSave = self.categories
        }
    }
}

extension AddMovieViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        //TODO - Fazer proporcinal de acordo com a imagem
        let smallSize = CGSize(width: image.size.width/10, height: image.size.height/10)
        UIGraphicsBeginImageContext(smallSize)
        
        image.draw(in: CGRect(x: 0.0, y: 0.0, width: smallSize.width, height: smallSize.height))
        guard let smallImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        
        UIGraphicsEndImageContext()
        
        posterImage.image = smallImage
        dismiss(animated: true, completion: nil)
    }
}

extension AddMovieViewController:CategoriesListProtocol{
    
    func saveCategories(categories: [Category]) {
        
        self.categories = categories
    }
}
