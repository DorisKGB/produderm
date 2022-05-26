class Api {
  static const String baseUrl = 'https://app.produderm.com.ec:9443';
}

enum EndPoint { login, listClients, listProducts, lisVisits, admin }

extension DetailEndPoint on EndPoint {
  String getPath() {
    switch (this) {
      case EndPoint.login:
        return '${Api.baseUrl}/api/login';
      case EndPoint.listClients:
        return '${Api.baseUrl}/api/clients';
      case EndPoint.listProducts:
        return '${Api.baseUrl}/api/products';
      case EndPoint.lisVisits:
        return '${Api.baseUrl}/api/activities';
      case EndPoint.admin:
        return '${Api.baseUrl}/api/users/me';
    }
  }
}
