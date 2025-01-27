enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  searchRoute("/search"),
  favoriteRoute("/favorite"),
  settingRoute("/settings");

  const NavigationRoute(this.name);
  final String name;
}
