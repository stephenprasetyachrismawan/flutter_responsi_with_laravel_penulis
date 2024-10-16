class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listPenulis = baseUrl + '/buku/penulis';
  static const String createPenulis = baseUrl + '/buku/penulis';

  static String updatePenulis(int id) {
    return baseUrl + '/buku/penulis/' + id.toString() + '/update';
  }

  static String showPenulis(int id) {
    return baseUrl + '/buku/penulis/' + id.toString();
  }

  static String deletePenulis(int id) {
    return baseUrl + '/buku/penulis/' + id.toString() + '/delete';
  }
}
