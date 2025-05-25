abstract final class Routes {
  static const String initialRoute = '/';
  static const String todos = '/todos';
  static String todoDetails(String id) => '$todos/$id';
}
