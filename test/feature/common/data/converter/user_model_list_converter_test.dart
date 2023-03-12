import 'package:flutter_test/flutter_test.dart';
import 'package:github_favs/core/data/converter/converter.dart';
import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/model/api_response_model.dart';
import 'package:github_favs/feature/common/data/converter/user_model_list_converter.dart';
import 'package:github_favs/feature/common/data/model/user_model_list.dart';

void main() {
  final userModelConverter = UserModelListConverter();
  final userModel = UserModelList();

  const apiResposneModel = ApiResponseModel(
    body: '',
    url: '',
    statusCode: 200,
    headers: {},
  );

  test('should inherit ApiResponseModelConverter<UserModelList>', () {
    expect(userModelConverter, isA<ApiResponseModelConverter<UserModelList>>());
  });
  test(
    'should throw a AppException.parsingException()',
    () async {
      expect(
        () => userModelConverter.convert(apiResposneModel),
        throwsA(const AppException.parsingException()),
      );
    },
  );
}
