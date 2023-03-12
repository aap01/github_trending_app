import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/country_list/country_list_bloc.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/country_list/country_list_state.dart';
import 'package:github_favs/feature/top_user/presentation/bloc/top_user/top_user_bloc.dart';

class CountryDropDownWidget extends StatefulWidget {
  const CountryDropDownWidget({
    super.key,
  });

  @override
  State<CountryDropDownWidget> createState() => _CountryDropDownWidgetState();
}

class _CountryDropDownWidgetState extends State<CountryDropDownWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CountryListBloc>().populateCountryList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<CountryListBloc, CountryListState>(
          builder: (context, state) {
            if (state.countryList.isNotEmpty) {
              return DropdownMenu<CountryEntity>(
                initialSelection: state.countryList[0],
                enableSearch: true,
                onSelected: (value) async {
                  if (value != null) {
                    await context.read<TopUserBloc>().setCountry(
                          value.id,
                        );
                  }
                },
                dropdownMenuEntries: state.countryList.map((e) {
                  return DropdownMenuEntry(
                    value: e,
                    label: e.name,
                  );
                }).toList(),
              );
            }
            return const Align(
              alignment: Alignment.topLeft,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}
