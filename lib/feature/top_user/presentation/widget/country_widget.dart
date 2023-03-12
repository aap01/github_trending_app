import 'package:flutter/material.dart';
import 'package:github_favs/feature/top_user/domain/entity/country_entity.dart';

class CountryWidget extends StatelessWidget {
  final CountryEntity countryEntity;
  final Function(int) onTap;
  const CountryWidget({
    super.key,
    required this.countryEntity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap(
        countryEntity.id,
      ),
      child: Text(
        countryEntity.name,
      ),
    );
  }
}
