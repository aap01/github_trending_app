import 'package:github_favs/core/data/converter/converter.dart';
import 'package:github_favs/core/data/model/api_response_model.dart';
import 'package:github_favs/feature/top_repo/data/model/repo_model.dart';

class RepoModelConverter extends ApiResponseModelConverter<RepoModel> {
  @override
  RepoModel convert(ApiResponseModel from) {
    return super.runThroughParsingExceptionCatcher(
      () => RepoModel.fromJson(
        super.decode(from.body),
      ),
    );
  }
}
