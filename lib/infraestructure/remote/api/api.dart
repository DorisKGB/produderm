class Api {
  static const String baseUrl = 'https://app.produderm.com.ec:9443';
}

enum EndPoint { login, clients, products, visits, admin, specialities }

extension DetailEndPoint on EndPoint {
  String getPath() {
    switch (this) {
      case EndPoint.login:
        return '${Api.baseUrl}/api/login';
      case EndPoint.clients:
        return '${Api.baseUrl}/api/clients';
      case EndPoint.products:
        return '${Api.baseUrl}/api/products';
      case EndPoint.visits:
        return '${Api.baseUrl}/api/activities';
      case EndPoint.admin:
        return '${Api.baseUrl}/api/users/me';
      case EndPoint.specialities:
        return '${Api.baseUrl}/api/specialties';
    }
  }
}
