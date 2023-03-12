import 'package:github_favs/core/data/converter/converter.dart';
import 'package:github_favs/core/data/model/api_response_model.dart';
import 'package:github_favs/feature/common/data/model/user_model_list.dart';

class UserModelListConverter extends ApiResponseModelConverter<UserModelList> {
  @override
  UserModelList convert(ApiResponseModel from) {
    return super.runThroughParsingExceptionCatcher(() {
      return UserModelList.fromJson(super.decode(from.body));
    });
  }
}
