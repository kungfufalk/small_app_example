///Todo: group routes with names and titles into classes

class AppRoutes {
  static const home = '/';
  static const camera = '/camera';
  static const collection = '/collection';

  static const browse = '/';
  static const settings = '/settings';

  static const create = '/create';
  static const categoryCreation = 'category';
  static const collectionCreation = 'collection';
  static const itemCreation = 'item';
  static const categoryFullPath = '$create/$categoryCreation';
  static const collectionFullPath = '$create/$collectionCreation';
  static const itemFullPath = '$create/$itemCreation';
}

class RouteNames {
  static const home = 'HOME';
  static const camera = 'CAMERA';
  static const item = 'ITEM';
  static const collection = 'COLLECTION';
  static const category = 'CATEGORY';

  static const browse = 'BROWSE';
  static const create = 'CREATE';
  static const settings = 'SETTINGS';
}

class RouteTitles {
  static const home = 'Home';
  static const camera = 'Camera';
  static const item = 'Item';
  static const collection = 'Collection';
  static const category = 'Category';

  static const browse = 'Browse';
  static const create = 'Create';
  static const settings = 'Settings';
}