import 'package:github_favs/core/data/mapper/mapper.dart';
import 'package:github_favs/feature/top_user/data/model/country_model.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';

class CountryEntityMapper extends MapperImpl<CountryModel, CountryEntity> {
  @override
  CountryEntity map(CountryModel from) {
    return super.runThroughMappingExceptionCatcher(
      () => CountryEntity(
        id: from.id,
        name: from.name,
      ),
    );
  }
}
