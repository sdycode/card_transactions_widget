


// Enum Definitions
import 'dart:math';

enum TransactionType { credit, debit }

enum Category {
  foodAndDining,
  transportation,
  shopping,
  entertainment,
  healthAndFitness,
  utilitiesAndBills,
  travel,
  education,
  financial,
  miscellaneous
}

enum Subcategory {
  groceries,
  restaurants,
  fastFood,
  coffeeShops,
  barsAndNightlife,
  gasAndFuel,
  publicTransit,
  rideSharing,
  parking,
  carRental,
  clothing,
  electronics,
  homeGoods,
  beautyAndPersonalCare,
  gifts,
  moviesAndShows,
  streamingServices,
  eventsAndConcerts,
  gaming,
  booksAndMagazines,
  gymAndFitness,
  medicalExpenses,
  pharmacy,
  sportsEquipment,
  wellnessAndSpa,
  electricity,
  water,
  internet,
  mobilePhone,
  subscriptionServices,
  airfare,
  hotelAndAccommodation,
  vacationPackages,
  toursAndActivities,
  carRentals,
  coursesAndClasses,
  booksAndSupplies,
  tuition,
  onlineLearning,
  schoolFees,
  bankFees,
  investments,
  loanPayments,
  creditCardPayments,
  savingsAndDeposits,
  charityAndDonations,
  pets,
  homeMaintenance,
  other,
}


// Helper function to get a random subcategory for a given category
Subcategory getRandomSubcategoryForCategory(Category category) {
  List<Subcategory> subcategories;
  switch (category) {
    case Category.foodAndDining:
      subcategories = [
        Subcategory.groceries,
        Subcategory.restaurants,
        Subcategory.fastFood,
        Subcategory.coffeeShops,
        Subcategory.barsAndNightlife,
      ];
      break;
    case Category.transportation:
      subcategories = [
        Subcategory.gasAndFuel,
        Subcategory.publicTransit,
        Subcategory.rideSharing,
        Subcategory.parking,
        Subcategory.carRental,
      ];
      break;
    // Define other cases similarly
    default:
      subcategories = [Subcategory.other];
  }
  Random random = Random();
  return subcategories[random.nextInt(subcategories.length)];
}
 