enum AppPage {
  splash(name: 'splash', path: '/splash', fullPath: '/splash'),

  home(name: 'home', path: '/home', fullPath: '/home'),
  tab(name: 'tab', path: '/tab', fullPath: '/tab'),
  login(name: 'login', path: '/login', fullPath: '/login');

  const AppPage({
    required this.path,
    required this.name,
    required this.fullPath,
  });

  final String path;
  final String fullPath;
  final String name;

  static AppPage fromMatchLocation(String location) {
    final page =
        AppPage.values.firstWhere((element) => element.path == location);
    return page;
  }
}
