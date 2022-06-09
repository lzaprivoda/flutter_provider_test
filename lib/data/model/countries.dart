import 'package:json_annotation/json_annotation.dart';

part 'countries.g.dart';

/// For source code generator
const jsonSerializable = JsonSerializable(explicitToJson: true, includeIfNull: false);

@jsonSerializable
class Countries {
  final List<Country> countries;

  Countries({
    required this.countries,
  });

  List<Country> getCountries() => countries;

  factory Countries.fromJson(Map<String, dynamic> json) => _$CountriesFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesToJson(this);
}

@jsonSerializable
class Country {

  final String? name;
  final String? native;
  final String? capital;
  final String? emoji;
  final String? currency;
  final List<Language> languages;

  Country({
    required this.name,
    required this.native,
    required this.capital,
    required this.emoji,
    required this.currency,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@jsonSerializable
class Language {

  final String? code;
  final String? name;

  Language({
    required this.code,
    required this.name,

  });

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

