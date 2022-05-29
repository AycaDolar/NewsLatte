class CategoryModel {
  late String imageAssetUrl;
  late String categoryName;
  late String category;
}

List<CategoryModel> getCategories() {
  List<CategoryModel> myCategories = [];
  CategoryModel categoryModel;

  //1
  categoryModel = CategoryModel();
  categoryModel.categoryName = "business";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1491336477066-31156b5e4f35?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80";
  myCategories.add(categoryModel);

  //2
  categoryModel = CategoryModel();
  categoryModel.categoryName = "entertainment";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1598387181032-a3103a2db5b3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1176&q=80";
  myCategories.add(categoryModel);

  //3
  categoryModel = CategoryModel();
  categoryModel.categoryName = "general";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1491438590914-bc09fcaaf77a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80";
  myCategories.add(categoryModel);

  //4
  categoryModel = CategoryModel();
  categoryModel.categoryName = "health";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1532938911079-1b06ac7ceec7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1332&q=80";
  myCategories.add(categoryModel);

  //5
  categoryModel = CategoryModel();
  categoryModel.categoryName = "science";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1507413245164-6160d8298b31?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80";
  myCategories.add(categoryModel);

  //5
  categoryModel = CategoryModel();
  categoryModel.categoryName = "sports";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categoryModel);

  //5
  categoryModel = CategoryModel();
  categoryModel.categoryName = "technology";
  categoryModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categoryModel);

  return myCategories;
}
