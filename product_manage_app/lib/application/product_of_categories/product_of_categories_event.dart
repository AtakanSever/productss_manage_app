abstract class EventProductOfCategories {}

class EventProductOfCategoriesGetInfo extends EventProductOfCategories {
  final String selectedCategory;

  EventProductOfCategoriesGetInfo({required this.selectedCategory});
}