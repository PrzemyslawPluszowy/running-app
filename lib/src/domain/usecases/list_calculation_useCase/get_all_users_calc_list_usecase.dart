import 'package:new_app/src/data/datasources/remote_data_source.dart';

import '../../entities/calcuate_entity.dart';

class GetAllUsersCalcList {
  final RemoteDataSource remoteDataSource;

  GetAllUsersCalcList({required this.remoteDataSource});

  Stream<List<CalcluateEntity>> call() {
    return remoteDataSource.getAllUserList();
  }
}
