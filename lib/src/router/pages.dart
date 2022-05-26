enum Pages {
  signIn,
  main,
  createCliente,
  createVisit,
  listProduct,
}

extension PagesExtension on Pages {
  String getPath() {
    switch (this) {
      case Pages.signIn:
        return "/sign-in";
      case Pages.main:
        return "/main";
      case Pages.createCliente:
        return "/create_cliente";
      case Pages.createVisit:
        return "/create_visit";
      case Pages.listProduct:
        return "/list-product";
    }
  }

  String getKey() {
    switch (this) {
      case Pages.signIn:
        return "sign-in";
      case Pages.main:
        return "main";
      case Pages.createCliente:
        return "create-ciente";
      case Pages.createVisit:
        return "create-visit";
      case Pages.listProduct:
        return "list-product";
    }
  }
}
