enum Nationality { indonesia, other }

class ParentDataEntity {
  final String? nik;
  final String? fullName;
  final String? birthPlace;
  final DateTime? birthDate;
  final Nationality nationality;
  final String? otherNationality;
  final String? religion;
  final String? address;
  final String? education;
  final String? occupation;
  final String? workplace;
  final String? income;
  final String? phoneNumber;
  final String? email;
  final bool hasSpecialNeeds;

  ParentDataEntity({
    this.nik,
    this.fullName,
    this.birthPlace,
    this.birthDate,
    this.nationality = Nationality.indonesia,
    this.otherNationality,
    this.religion,
    this.address,
    this.education,
    this.occupation,
    this.workplace,
    this.income,
    this.phoneNumber,
    this.email,
    this.hasSpecialNeeds = false,
  });
}
