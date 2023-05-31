enum AppRoute {
  news,
  addNews,
  editNews,
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.news:
        return "/news";
      case AppRoute.addNews:
        return "addNews";
      case AppRoute.editNews:
        return "editNews";
      default:
        return "/news";
    }
  }

  int get currentIndex {
    switch (this) {
      case AppRoute.news:
        return 0;
      default:
        return 0;
    }
  }
}
