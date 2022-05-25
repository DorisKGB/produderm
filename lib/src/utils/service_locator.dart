import 'package:produderm/application/repository/r_visit.dart';
import 'package:produderm/infraestructure/r_visit_imp.dart';

import '../../application/repository/r_client.dart';
import '../../application/repository/r_product.dart';
import '../../application/repository/r_user.dart';
import '../../application/repository/r_user_local.dart';
import '../../infraestructure/local/r_user_local_imp.dart';
import '../../infraestructure/r_client_imp.dart';
import '../../infraestructure/r_product_imp.dart';
import '../../infraestructure/r_user_imp.dart';

//Para iniciar los repositorios
class ServiceLocator {
  //Repositories
  RUser get rUser => RUserImp();
  RUserLocal get rUserLocal => RUserLocalImp();
  RClient get rClient => RClientImp(rUserLocal);
  RProduct get rProduct => RProductImp(rUserLocal);
  RVisit get rVisit => RVisitImp(rUserLocal);
}
