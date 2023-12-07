class Donor {
  final String id;
  final String userId;
  final String? name;
  final String? aadharNumber;
  final String? mobileNumber;
  final List<DonationHistory>? donationHistory;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Donor({
    required this.id,
    required this.userId,
    this.name,
    this.aadharNumber,
    this.mobileNumber,
    this.donationHistory,
    this.createdAt,
    this.updatedAt,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    final historyList = json['donationHistory'] as List?;
    return Donor(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
      aadharNumber: json['aadharNumber'],
      mobileNumber: json['mobileNumber'],
      donationHistory: historyList != null
          ? historyList.map((item) => DonationHistory.fromJson(item)).toList()
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'aadharNumber': aadharNumber,
      'mobileNumber': mobileNumber,
      'donationHistory': donationHistory?.map((item) => item.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class DonationHistory {
  final String? bloodGroup;
  final DateTime? donationDate;

  DonationHistory({
    this.bloodGroup,
    this.donationDate,
  });

  factory DonationHistory.fromJson(Map<String, dynamic> json) {
    return DonationHistory(
      bloodGroup: json['bloodGroup'],
      donationDate: json['donationDate'] != null
          ? DateTime.parse(json['donationDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bloodGroup': bloodGroup,
      'donationDate': donationDate?.toIso8601String(),
    };
  }
}
