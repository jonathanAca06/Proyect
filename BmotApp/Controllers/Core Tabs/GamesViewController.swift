//
//  GamesViewController.swift
//  BmotApp
//
//  Created by jhon on 05/11/21.
//

import UIKit

class GamesViewController: UIViewController {
    
    //MARK: Variables privadas de uso
    //Data Source for CollectionView-1
    private let emocion_color = [
        "Miedo":"Verde oscuro",
        "Afecto":"Verde claro",
        "Tristeza":"Azul oscuro",
        "Enojo":"Rojo",
        "Alegria":"Amarillo"]
    
    private var dictyonary_items = [
        "felicidad": "Alegria",
        "afecto":"Afecto",
        "agradecimiento":"Afecto",
        "furia":"Enojo",
        "disgusto":"Enojo",
        "contento":"Alegria",
        "encanto":"Alegria",
        "soledad":"Tristeza",
        "tristeza":"Tristeza",
        "desconsuelo":"Tristeza",
        "duda":"Miedo",
        "enfado":"Enojo",
        "timidez":"Miedo",
        "temor":"Miedo"]
    
    private var items1 = [String]()
    
    //private var items1 = ["felicidad", "afecto", "agradecimiento", "furia", "disgusto", "contento", "encanto", "soledad", "tristeza", "desconsuelo", "duda","enfado","timidez", "temor"]
    

    
    //Data Source for CollectionView-2
    private var items2 = [String]()
    
    //Variables
    private var cont: Int = 0
    private var timer = Timer()
    private var pressbtn = false
    
    //MARK: Outlets
    @IBOutlet weak var collectionview_1: UICollectionView!
    
    @IBOutlet weak var collectionview_2: UICollectionView!
   
    @IBOutlet weak var fondo_imageView: UIImageView!
    
//MARK: View Lifecycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //items1 configuracion de listado
        self.items1 = Array(dictyonary_items.keys)
        
        //CollectionView1 configuracion de Drag and Drop
        self.collectionview_1.dragInteractionEnabled = false
        self.collectionview_1.dragDelegate = self
        self.collectionview_1.dropDelegate = self
        
        //CollectionView2 configuracion de Drag and Drop
        self.collectionview_2.dragInteractionEnabled = true
        self.collectionview_2.dragDelegate = self
        self.collectionview_2.dropDelegate = self
        self.collectionview_2.reorderingCadence = .fast
        
        
    }
    //MARK: Metodos de botones
    //Metodo del boton play
    @IBAction func playButton(_ sender: UIButton) {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timer_action), userInfo: nil, repeats: true)
        self.collectionview_1.dragInteractionEnabled = true
        
        
    }
    
    /// Metodo del boton stop
    @IBAction func stopButton(_ sender: UIButton) {
        self.collectionview_1.dragInteractionEnabled = false
        timer.invalidate()
        
        var cont_emociones = [
                    "Miedo":0,
                    "Afecto":0,
                    "Tristeza":0,
                    "Enojo":0,
                    "Alegria":0]
        
        for item in items2{
            print("Contenido items2: \(item)")
        }
        
        for code in items2{
            if let mensaje = dictyonary_items[code]{
                cont_emociones[mensaje]! += 1
                
            }else {
                print("No hay rebanadas")
            }
        }
         
        
        
        for (emocion,valor) in cont_emociones{
            print("Contenido cont_emociones: \(emocion):\(valor)")
            if(emocion == "Miedo"  && valor > 0 && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                
                self.fondo_imageView.backgroundColor = UIColor.init(red: 0, green: 123, blue: 0, alpha: 1)
            }
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                
                self.fondo_imageView.backgroundColor = UIColor.init(red: 0, green: 255, blue: 77, alpha: 0.9)
            }
            if (emocion == "Tristeza"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]! ) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                self.fondo_imageView.backgroundColor = UIColor.init(red: 91, green: 0, blue: 255, alpha: 1)
            }
            if (emocion == "Enojo"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Alegria"]!) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                
                self.fondo_imageView.backgroundColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 1)
            }
            if (emocion == "Alegria"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]!) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
               
                self.fondo_imageView.backgroundColor = UIColor.init(red: 255, green: 255, blue: 0, alpha: 1)
            }
        
        
        }
        //dump(cont_emociones)
        
        
        
    }
    
    @objc private func timer_action(){
        cont += 1
        print("Timer:\(cont)")
        
    }
    
    /// Metodo del boton reset
    @IBAction func resetButton(_ sender: UIButton) {
        print("Se reincio el juego")
        self.pressbtn = true
        if (self.pressbtn == true){
            self.items2 = [String]()
            self.cont = 0
            self.fondo_imageView.backgroundColor = UIColor.white
            self.collectionview_2.reloadData()
            
        }
        self.collectionview_1.dragInteractionEnabled = false
        
        //print(self.cont)
        //dump(items2)
        
    }
    
    //MARK: Metodos de funcionamiento
    
    /// This method moves a cell from source indexPath to destination indexPath within the same collection view. It works for only 1 item. If multiple items selected, no reordering happens.
    ///
    /// - Parameters:
    ///   - coordenadas: coordinator obtained from performDropWith: UICollectionViewDropDelegate method
    ///   - destinoIndexPath: indexpath of the collection view where the user drops the element
    ///   - collectionView: collectionView in which reordering needs to be done.
    
    private func reorderItems(coordinator:UICollectionViewDropCoordinator, destinationIndexPath:IndexPath, collectionView:UICollectionView)
    {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath
        {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= collectionView.numberOfItems(inSection: 0)
            {
                dIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            collectionView.performBatchUpdates({
                if collectionView == self.collectionview_2
                {
                    self.items2.remove(at: sourceIndexPath.row)
                    self.items2.insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                    
                }
                else
                {
                    self.items1.remove(at: sourceIndexPath.row)
                    self.items1.insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                }
        
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [dIndexPath])
            })
            coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
        }
    }
    
    /// This method copies a cell from source indexPath in 1st collection view to destination indexPath in 2nd collection view. It works for multiple items.
    ///
    /// - Parameters:
    ///   - coordinator: coordinator obtained from performDropWith: UICollectionViewDropDelegate method
    ///   - destinationIndexPath: indexpath of the collection view where the user drops the element
    ///   - collectionView: collectionView in which reordering needs to be done.
    private func copyItems(coordinator:UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        collectionView.performBatchUpdates({
            var indexPaths = [IndexPath]()
            for (index, item) in coordinator.items.enumerated()
            {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                if collectionView == self.collectionview_2
                {
                    self.items2.insert(item.dragItem.localObject as! String, at: indexPath.row)
                    
                }
                else
                {
                    self.items1.insert(item.dragItem.localObject as! String, at: indexPath.row)
                }
                indexPaths.append(indexPath)
                
            }
            collectionView.insertItems(at: indexPaths)
        })
    }
}
// MARK: - UICollectionViewDataSource Methods
extension GamesViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return collectionView == self.collectionview_1 ? self.items1.count : self.items2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.collectionview_1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! GamePizzaCollectionViewCell
            cell.customImageView?.image = UIImage(named: self.items1[indexPath.row])
            cell.customLabel.text = self.items1[indexPath.row].capitalized
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! GamePizzaCollectionViewCell
            cell.customImageView?.image = UIImage(named: self.items2[indexPath.row])
            cell.customLabel.text = self.items2[indexPath.row].capitalized
            return cell
        }
        
    }
    
}
// MARK: - UICollectionViewDragDelegate Methods
extension GamesViewController : UICollectionViewDragDelegate
{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem]
    {
        let item = collectionView == collectionview_1 ? self.items1[indexPath.row] : self.items2[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem]
    {
        let item = collectionView == collectionview_1 ? self.items1[indexPath.row] : self.items2[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?
    {
        if collectionView == collectionview_1
        {
            let previewParameters = UIDragPreviewParameters()
            previewParameters.visiblePath = UIBezierPath(rect: CGRect(x: 25, y: 25, width: 120, height: 120))
            return previewParameters
        }
        return nil
    }
}
// MARK: - UICollectionViewDropDelegate Methods
extension GamesViewController : UICollectionViewDropDelegate
{
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool
    {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        if collectionView === self.collectionview_1
        {
            if collectionView.hasActiveDrag{
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            else
            {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
        }
        else
        {
            if collectionView.hasActiveDrag
            {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            else
            {
                return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
            }
            
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath: IndexPath
        if let indexPath  = coordinator.destinationIndexPath
        {
            destinationIndexPath = indexPath
        }
        else
        {
            // Get last index path of table view.
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        switch coordinator.proposal.operation
        {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            break
                    
        case .copy:
            self.copyItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        
        default:
            return
        }
        
    }
    
}


