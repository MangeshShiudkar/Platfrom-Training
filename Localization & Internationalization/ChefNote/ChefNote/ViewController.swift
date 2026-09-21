import UIKit

class ViewController: UIViewController {

    let titleLabel = UILabel()
    let chefLabel = UILabel()
    
    let servingsView = UIView()
    let servingsImageView = UIImageView()
    let servingsLabel = UILabel()
    
    let ingredientsLabel = UILabel()
    let ingredientsView = UIView()
    let ingredientOneLabel = UILabel()
    let ingredientTwoLabel = UILabel()
    let ingredientThreeLabel = UILabel()

    let instructionsLabel = UILabel()
    let instructionsView = UIView()
    let instructionsText = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabelsAndView()
        setupLayout()
    }
    
    // Setup all the labels, localized text and required formatting
    func setupLabelsAndView() {
        titleLabel.text = NSLocalizedString("recipe_title",comment: "Title of the recipe")
        titleLabel.font = .boldSystemFont(ofSize: 30)
        
        // Used placeholder for the chef name so the complete sentence can be localized
        let chefName = "Chef Antoine"
        chefLabel.text = String.localizedStringWithFormat(NSLocalizedString("recipe_by",comment: "Text showing who created the recipe"),
            chefName
        )
        chefLabel.font = .systemFont(ofSize: 18)
        chefLabel.textColor = .systemGray
        
        // Setup the servings view and serving count
        servingsImageView.image = UIImage(systemName: "person.circle.fill")
        servingsImageView.contentMode = .scaleAspectFill
        servingsImageView.clipsToBounds = true
        servingsView.backgroundColor = .systemMint
        servingsView.layer.cornerRadius = 17
        
        // Used String Catalog pluralization for the serving count
        let servingCount = 1
        servingsLabel.text = String.localizedStringWithFormat(NSLocalizedString("item_count",comment: "Number of servings"),
            servingCount
        )
        servingsLabel.font = .systemFont(ofSize: 18)
        servingsLabel.textColor = .white
        
        // Localize the ingredients section title
        ingredientsLabel.text = NSLocalizedString("ingredients",comment: "Section title for ingredients")
        ingredientsLabel.font = .boldSystemFont(ofSize: 20)
        ingredientsLabel.textColor = .systemGray
        
        ingredientsView.backgroundColor = .systemGray5
        ingredientsView.layer.cornerRadius = 10
        
        // Format the ingredient quantity using MeasurementFormatter
        let flour = Measurement(value: 500,unit: UnitMass.grams)
        let measurementFormatter = MeasurementFormatter()
        // Keep the quantity in the provided unit instead of converting it
        measurementFormatter.unitOptions = [.providedUnit]
        let flourQuantity = measurementFormatter.string(from: flour)
        let flourName = NSLocalizedString("flour",comment: "Name of the first ingredient")
        ingredientOneLabel.text = "\(flourName) - \(flourQuantity)"
        ingredientTwoLabel.text = NSLocalizedString("ingredient_two",comment: "Second ingredient with quantity")
        ingredientThreeLabel.text = NSLocalizedString("ingredient_three",comment: "Third ingredient with quantity")
        
        instructionsLabel.text = NSLocalizedString("instructions",comment: "Section title for instructions")
        instructionsLabel.font = .boldSystemFont(ofSize: 20)
        instructionsLabel.textColor = .systemGray
        
        instructionsView.backgroundColor = .systemGray5
        instructionsView.layer.cornerRadius = 10
        
        instructionsText.text = NSLocalizedString("instructions_text",comment: "Recipe preparation instructions")
        // Allow longer translated text to display on multiple lines
        instructionsText.numberOfLines = 0
        instructionsText.textAlignment = .natural
    }
    
    // Setup the views and constraints for the recipe screen
    func setupLayout() {
        let servingStackView = UIStackView(arrangedSubviews: [servingsImageView, servingsLabel])
        servingStackView.axis = .horizontal
        servingStackView.spacing = 20
        servingsView.addSubview(servingStackView)
        servingStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servingStackView.topAnchor.constraint(equalTo: servingsView.topAnchor, constant: 10),
            servingStackView.leadingAnchor.constraint(equalTo: servingsView.leadingAnchor,constant: 10),
            servingStackView.trailingAnchor.constraint(equalTo: servingsView.trailingAnchor,constant: -10),
            servingStackView.bottomAnchor.constraint(equalTo: servingsView.bottomAnchor,constant: -10),

            servingsImageView.widthAnchor.constraint(equalToConstant: 30),
            servingsImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let ingredientStackView = UIStackView(arrangedSubviews: [ingredientOneLabel,ingredientTwoLabel,ingredientThreeLabel])
        ingredientStackView.axis = .vertical
        ingredientStackView.spacing = 20
        ingredientsView.addSubview(ingredientStackView)
        ingredientStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientStackView.topAnchor.constraint(equalTo: ingredientsView.topAnchor,constant: 10),
            ingredientStackView.leadingAnchor.constraint(equalTo: ingredientsView.leadingAnchor,constant: 10),
            ingredientStackView.trailingAnchor.constraint(equalTo: ingredientsView.trailingAnchor,constant: -10),
            ingredientStackView.bottomAnchor.constraint(equalTo: ingredientsView.bottomAnchor,constant: -10)
        ])
        
        instructionsView.addSubview(instructionsText)
        instructionsText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionsText.topAnchor.constraint(equalTo: instructionsView.topAnchor,constant: 10),
            instructionsText.leadingAnchor.constraint(equalTo: instructionsView.leadingAnchor,constant: 10),
            instructionsText.trailingAnchor.constraint(equalTo: instructionsView.trailingAnchor,constant: -10),
            instructionsText.bottomAnchor.constraint(equalTo: instructionsView.bottomAnchor,constant: -10)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            chefLabel,
            servingsView,
            ingredientsLabel,
            ingredientsView,
            instructionsLabel,
            instructionsView
        ])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
        ])
    }
}
