import 'package:totowala/core/api/api_manager/api_manager_base.dart';
import 'package:totowala/domain/repository/splash/splash_repository.dart';

class SplashRepositoryImplement implements SplashRepository{
  final ApiManagerBase _apiManagerBase;
  SplashRepositoryImplement(this._apiManagerBase);
  @override
  Future<String?> refreshToken() async{
    try{
      final response = await _apiManagerBase.refreshAuthToken();
      if(response!=null){
        return response;
      }else{
        throw Exception();
      }
    }catch(e){
      rethrow;
    }
  }

}