class ChildDataEntity {
  // Data Pribadi
  final String? nis;
  final String? nisn;
  final String? fullName;
  final String? gender;
  final String? nik;
  final String? familyCardNumber;
  final String? birthCertificateNo;
  final String? birthPlace;
  final String? examParticipantNo;
  final String? diplomaSerialNo;
  final String? skhunSerialNo;
  final String? kisNo;
  final int? childOrder;
  final String? bloodType;
  final String? familyStatus;
  final String? parentStatus;
  final String? nationality;
  final String? otherNationality;
  final String? religion;
  final String? phoneNumber;
  final bool hasSpecialNeeds;

  // Data Alamat
  final String? address;
  final String? rt;
  final String? rw;
  final String? hamlet;
  final String? subDistrict;
  final String? village;
  final String? district;
  final String? postalCode;
  final String? houseNumber;
  final String? latitude;
  final String? longitude;

  // Informasi Tambahan
  final String? transportation;
  final String? livingWith;
  final double? distanceToSchool;
  final int? travelTime;
  final double? height;
  final double? weight;
  final double? headCircumference;

  // Dokumen
  final String? passPhoto;
  final String? fullBodyPhoto;
  final String? familyCard;
  final String? diploma;
  final String? studentCard;
  final String? birthCertificate;
  final String? specialNeedsDoc;
  final String? achievementProof;

  // Informasi Sekolah & Program
  final String? previousSchool;
  final String? previousSchoolAddress;
  final bool receivesKps;
  final String? kpsNo;
  final bool receivesKip;
  final String? kipNo;
  final String? kksNo;
  final bool eligibleForPip;
  final String? pipReason;

  // Informasi Bank
  final String? bankName;
  final String? accountNumber;
  final bool hasMutation;
  final String? mutationFrom;
  final String? savingsType;

  ChildDataEntity({
    this.nis,
    this.nisn,
    this.fullName,
    this.gender,
    this.nik,
    this.familyCardNumber,
    this.birthCertificateNo,
    this.birthPlace,
    this.examParticipantNo,
    this.diplomaSerialNo,
    this.skhunSerialNo,
    this.kisNo,
    this.childOrder,
    this.bloodType,
    this.familyStatus,
    this.parentStatus,
    this.nationality,
    this.otherNationality,
    this.religion,
    this.phoneNumber,
    this.hasSpecialNeeds = false,
    this.address,
    this.rt,
    this.rw,
    this.hamlet,
    this.subDistrict,
    this.village,
    this.district,
    this.postalCode,
    this.houseNumber,
    this.latitude,
    this.longitude,
    this.transportation,
    this.livingWith,
    this.distanceToSchool,
    this.travelTime,
    this.height,
    this.weight,
    this.headCircumference,
    this.passPhoto,
    this.fullBodyPhoto,
    this.familyCard,
    this.diploma,
    this.studentCard,
    this.birthCertificate,
    this.specialNeedsDoc,
    this.achievementProof,
    this.previousSchool,
    this.previousSchoolAddress,
    this.receivesKps = false,
    this.kpsNo,
    this.receivesKip = false,
    this.kipNo,
    this.kksNo,
    this.eligibleForPip = false,
    this.pipReason,
    this.bankName,
    this.accountNumber,
    this.hasMutation = false,
    this.mutationFrom,
    this.savingsType,
  });
}
