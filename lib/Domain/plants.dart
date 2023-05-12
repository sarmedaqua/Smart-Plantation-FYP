class Plant {
  final int plantId;
  final int price;
  final String size;
  // final double rating;
  final int humidity;
  final String temperature;
  final String category;
  final String plantName;
  final String imageURL;
  bool isFavorated;
  final String decription;
  bool isSelected;

  Plant(
      {required this.plantId,
        required this.price,
        required this.category,
        required this.plantName,
        required this.size,
        // required this.rating,
        required this.humidity,
        required this.temperature,
        required this.imageURL,
        required this.isFavorated,
        required this.decription,
        required this.isSelected});

  //List of Plants data
  static List<Plant> plantList = [
    Plant(
        plantId: 0,
        price: 22,
        category: 'Indoor',
        plantName: 'Calotrophis',
        size: 'Large',
        // rating: 4.5,
        humidity: 70,
        temperature: '20-35°C',
        imageURL: 'assets/images/plant-one.png',
        isFavorated: false,
        decription:
        'It is a large tropical plant that requires moderate to high humidity levels and warm to hot temperatures. It can grow up to 2-3 meters tall and is commonly used for medicinal purposes.',
        isSelected: false),
    Plant(
        plantId: 1,
        price: 11,
        category: 'Outdoor',
        plantName: 'Neem',
        size: 'Large',
        // rating: 4.8,
        humidity: 55,
        temperature: '20-40°C',
        imageURL: 'assets/images/plant-two.png',
        isFavorated: false,
        decription:
        'It is a large evergreen tree that can grow up to 15-20 meters tall. It requires well-draining soil and regular watering, and can tolerate a wide range of humidity levels. It grows best in warm to hot temperatures and is commonly used for medicinal purposes.',
        isSelected: false),
    Plant(
        plantId: 2,
        price: 18,
        category: 'Indoor',
        plantName: 'Oleander',
        size: 'Large',
        // rating: 4.7,
        humidity: 50,
        temperature: '15-35°C',
        imageURL: 'assets/images/plant-three.png',
        isFavorated: false,
        decription:
        'It is a large shrub or small tree that produces beautiful flowers and is commonly used as an ornamental plant. It requires well-draining soil and regular watering, and can tolerate a wide range of humidity levels. It prefers warm to hot temperatures and is well adapted to tropical and subtropical climates.',
        isSelected: false),
    Plant(
        plantId: 3,
        price: 30,
        category: 'Outdoor',
        plantName: 'Raavi',
        size: 'Medium',
        // rating: 4.5,
        humidity: 70,
        temperature: '20-30°C',
        imageURL: 'assets/images/plant-one.png',
        isFavorated: false,
        decription:
        'It is a medium-sized plant commonly used in Indian traditional medicine. It requires well-draining soil and regular watering to thrive. Raavi prefers moderate to high humidity levels and grows best in warm temperatures. It is well suited for tropical and subtropical climates.',
        isSelected: false),
    // Plant(
    //     plantId: 4,
    //     price: 24,
    //     category: 'Outdoor',
    //     plantName: 'Potato healthy',
    //     size: 'Small',
    //     // rating: 4.1,
    //     humidity: 70,
    //     temperature: '15-20°C',
    //     imageURL: 'assets/images/plant-four.png',
    //     isFavorated: true,
    //     decription:
    //     'Potatoes are cool-season crops that require moderate humidity levels and grow best in cool temperatures. They prefer well-draining soil and regular watering, but overwatering should be avoided. Healthy potatoes are a staple food in many parts of the world and are known for their nutritional value.',
    //     isSelected: false),
    Plant(
        plantId: 4,
        price: 24,
        category: 'Outdoor',
        plantName: 'Potato',
        size: 'Small',
        // rating: 4.1,
        humidity: 70,
        temperature: '15-20°C',
        imageURL: 'assets/images/plant-four.png',
        isFavorated: false,
        decription:
        'Potatoes are cool-season crops that require moderate humidity levels and grow best in cool temperatures. They prefer well-draining soil and regular watering, but overwatering should be avoided. Healthy potatoes are a staple food in many parts of the world and are known for their nutritional value.',
        isSelected: false),
    // Plant(
    //     plantId: 6,
    //     price: 19,
    //     category: 'Garden',
    //     plantName: 'Bell pepper healthy',
    //     size: 'Small',
    //     // rating: 4.2,
    //     humidity: 65,
    //     temperature: '18-25°C',
    //     imageURL: 'assets/images/plant-six.png',
    //     isFavorated: false,
    //     decription:
    //     'Bell peppers are warm-season crops that require moderate humidity levels and grow best in mild temperatures. They prefer well-draining soil and regular watering. Bell peppers are a good source of vitamin C and are commonly used in cooking. It is important to note that bell peppers can be sensitive to extreme heat or cold, so it is important to maintain the ideal temperature range.',
    //     isSelected: false),
    Plant(
        plantId: 5,
        price: 19,
        category: 'Garden',
        plantName: 'Bellpepper',
        size: 'Small',
        // rating: 4.2,
        humidity: 65,
        temperature: '18-25°C',
        imageURL: 'assets/images/plant-six.png',
        isFavorated: false,
        decription:
        'Bell peppers are warm-season crops that require moderate humidity levels and grow best in mild temperatures. They prefer well-draining soil and regular watering. Bell peppers are a good source of vitamin C and are commonly used in cooking. It is important to note that bell peppers can be sensitive to extreme heat or cold, so it is important to maintain the ideal temperature range.',
        isSelected: false),
  ];

  //Get the favorated items
  static List<Plant> getFavoritedPlants(){
    List<Plant> _travelList = Plant.plantList;
    return _travelList.where((element) => element.isFavorated == true).toList();
  }

  //Get the cart items
  static List<Plant> addedToCartPlants(){
    List<Plant> _selectedPlants = Plant.plantList;
    return _selectedPlants.where((element) => element.isSelected == true).toList();
  }
}

// Text(
// output,
// style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
// ),