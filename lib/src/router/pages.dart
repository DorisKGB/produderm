enum Pages {
  signIn,
  main,
  createCliente,
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
    }
  }
}
