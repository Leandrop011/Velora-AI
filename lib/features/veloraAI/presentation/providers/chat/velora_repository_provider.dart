import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/infrastructure.dart';

// ! PROVIDER QUE NOS DA UNA INSTANCIA DE NUESTRO REPOSITORY
final veloraRepositoryProvider = Provider(
  (ref) {
    return VeloraRepositoryImpl(datasource: VeloraDatasourceImpl());
  }
);
