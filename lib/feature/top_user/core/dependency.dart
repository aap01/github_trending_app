import 'package:get_it/get_it.dart';
import 'package:github_favs/core/data/converter/converter.dart';
import 'package:github_favs/core/data/local/local_datasource.dart';
import 'package:github_favs/core/data/mapper/mapper.dart';
import 'package:github_favs/core/data/model/api_response_model.dart';
import 'package:github_favs/core/domain/usecase/usecase.dart';
import 'package:github_favs/feature/common/data/converter/user_model_list_converter.dart';
import 'package:github_favs/feature/common/data/datasource/remote/user_remote_datasource.dart';
import 'package:github_favs/feature/common/data/mapper/user_entity_mapper.dart';
import 'package:github_favs/feature/common/data/model/user_model.dart';
import 'package:github_favs/feature/common/data/model/user_model_list.dart';
import 'package:github_favs/feature/common/data/repository/user_repository.dart';
import 'package:github_favs/feature/common/domain/entity/user_entity.dart';
import 'package:github_favs/feature/common/domain/entity/user_list.dart';
import 'package:github_favs/feature/common/domain/repository/user_repository.dart';
import 'package:github_favs/feature/top_user/data/datasource/local/country_local_data_source.dart';
import 'package:github_favs/feature/top_user/data/datasource/local/user_local_datasource.dart';
import 'package:github_favs/feature/top_user/data/mapper/country_entity_mapper.dart';
import 'package:github_favs/feature/top_user/data/mapper/user_details_mapper.dart';
import 'package:github_favs/feature/top_user/data/model/country_model.dart';
import 'package:github_favs/feature/top_user/data/repository/country_repository.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';
import 'package:github_favs/feature/top_user/domain/entity/user_details.dart';
import 'package:github_favs/feature/top_user/domain/repository/country_repository.dart';
import 'package:github_favs/feature/top_user/domain/usecase/get_country_list.dart';
import 'package:github_favs/feature/top_user/domain/usecase/get_top_users_by_country.dart';
import 'package:github_favs/feature/top_user/domain/usecase/get_user_details.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/country_list/country_list_bloc.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/top_user/top_user_bloc.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/user_details/user_details_bloc.dart';

class TopUserDepencency {
  final GetIt _sl;

  TopUserDepencency({required GetIt sl}) : _sl = sl;
  Future<void> init() async {
    //Presentation
    _sl.registerFactory(
      () => TopUserBloc(
        userListUC: _sl(),
      ),
    );
    _sl.registerFactory(
      () => CountryListBloc(
        countryListUC: _sl(),
      ),
    );

    _sl.registerFactory(
      () => UserDetailsBloc(userDetailsUC: _sl()),
    );

    //Domain
    _sl.registerFactory<Usecase<GetUsersByCountryInputParams, UserList>>(
      () => GetTopUsersByCountry(
        countryRepository: _sl(),
        userRepository: _sl(),
      ),
    );
    _sl.registerFactory<Usecase<NoParams, List<CountryEntity>>>(
        () => GetCountryList(countryRepository: _sl()));

    _sl.registerFactory<Usecase<GetUserDetailsInputParams, UserDetails>>(
      () => GetUserDetails(
        userRepository: _sl(),
      ),
    );

    //Data
    _sl.registerFactory<CountryRepository>(
      () => CountryRepositoryImpl(
        localDataSource: _sl(),
        countryEntityMapper: _sl(),
      ),
    );
    _sl.registerFactory<UserRepository>(
      () => UserRepositoryImpl(
        failureMapper: _sl(),
        userDetailsMapper: _sl(),
        userEntityMapper: _sl(),
        userRemoteDatasource: _sl(),
        userLocalDatasource: _sl(),
      ),
    );

    //Datasource
    _sl.registerLazySingleton<LocalDataSource<CountryModel>>(
      () => CountryLocalDataSource(map: {
        1: CountryModel(id: 1, name: 'Bangladesh'),
        2: CountryModel(id: 2, name: 'Russia'),
      }),
    );
    _sl.registerLazySingleton<LocalDataSource<UserModel>>(
      () => UserLocalDatasource(map: {}),
    );
    _sl.registerFactory<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(
        getApiClient: _sl(),
        queryStringGenerator: _sl(),
        modelConverter: _sl(),
      ),
    );

    //Mapper
    _sl.registerFactory<Mapper<CountryModel, CountryEntity>>(
      () => CountryEntityMapper(),
    );
    _sl.registerFactory<Mapper<UserModel, UserDetails>>(
      () => UserDetailsMapper(),
    );
    _sl.registerFactory<Mapper<UserModel, UserEntity>>(
      () => UserEntityMapper(),
    );
    _sl.registerFactory<Converter<ApiResponseModel, UserModelList>>(
      () => UserModelListConverter(),
    );
  }
}
