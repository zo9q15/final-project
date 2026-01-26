import '../models/tourist_place.dart';

final List<Map<String, dynamic>> rawData = [
  {
    'name': 'Riyadh City',
    'description': 'Riyadh is the capital of Saudi Arabia, known for its modern architecture, historical Souq Al Zal, and the vibrant Boulevard City. It is a hub of culture and business.',
    'mainImage': 'assets/images/place4.jpg',
    'galleryItems': [
      {
        'imagePath': 'assets/images/riyadh1.jpg',
        'description': 'Step into the future at KAFD, where cutting-edge architecture meets world-class dining and entertainment in the heart of Riyadh.'
      },
      {
        'imagePath': 'assets/images/riyadh2.jpg',
        'description': 'Travel back in time at historic Diriyah. Wander through the mud-brick palaces of At-Turaif and discover the birthplace of the Saudi state.'
      },
      {
        'imagePath': 'assets/images/riyadh3.jpg',
        'description': 'Unleash your inner thrill-seeker at Six Flags Qiddiya. Home to record-breaking rides and immersive attractions, it is the ultimate destination for adrenaline and family fun.'
      },
    ]
  },
  {
    'name': 'AlUla City',
    'description': 'AlUla is a living museum of preserved tombs and sandstone outcrops, home to Hegra, the first UNESCO World Heritage site in Saudi Arabia.',
    'mainImage': 'assets/images/place5.jpg',
    'galleryItems': [
      {
        'imagePath': 'assets/images/alula1.jpg',
        'description': 'Marvel at the geological wonder of Elephant Rock (Jabal AlFil). This iconic sandstone formation creates a spectacular silhouette against the golden desert sunset.'
      },
      {
        'imagePath': 'assets/images/alula2.jpg',
        'description': 'Explore the ancient mysteries of Hegra, Saudi Arabia’s first UNESCO World Heritage site. Admire the intricate tombs carved directly into the sandstone mountains.'
      },
      {
        'imagePath': 'assets/images/alula3.jpg',
        'description': 'Soar above history with a magical hot air balloon ride. Witness AlUla’s breathtaking canyons and golden landscapes from a unique vantage point in the sky.'
      },
    ]
  },
  {
    'name': 'Qassim City',
    'description': 'Qassim is the agricultural heart of the Kingdom, famous for its vast date farms, traditional festivals, and generous hospitality.',
    'mainImage': 'assets/images/place6.jpg',
    'galleryItems': [
      {
        'imagePath': 'assets/images/qassim1.jpg',
        'description': 'Immerse yourself in the worlds largest date market in Buraydah. Witness the vibrant auction season where millions of tons of premium dates are traded daily.'
      },
      {
        'imagePath': 'assets/images/qassim2.jpg',
        'description': 'Discover the heritage of legendary Arabian traders at the Aloqilat Museum. Admire the traditional mud-brick architecture and relive the history of ancient desert caravans.'
      },
      {
        'imagePath': 'assets/images/qassim3.jpg',
        'description': 'Gaze upon the endless green horizon of Al Rajhi Farm. Recognized as the largest date palm farm in the world, it is a breathtaking testament to Qassims agricultural abundance.'
      },
    ]
  },
];

List<TouristPlace> getPlaces() {
  return rawData.map((json) => TouristPlace.fromJson(json)).toList();
}