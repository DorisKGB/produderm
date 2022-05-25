CTypeClient clientcomCode(String? code) {
  return CTypeClient.values.firstWhere(
      (CTypeClient element) => element.getTypeClient() == code,
      orElse: () => CTypeClient.farmacia);
}

enum CTypeClient {
  farmacia,
  medico,
}

extension CTypeClientDetail on CTypeClient {
  getTypeClient() {
    switch (this) {
      case CTypeClient.farmacia:
        return 'FA';
      case CTypeClient.medico:
        return 'MD';
    }
  }

  getLabel() {
    switch (this) {
      case CTypeClient.farmacia:
        return 'Farmacia';
      case CTypeClient.medico:
        return 'Medico';
    }
  }
}
