class BloodRequest {
  final String bloodGroup;
  final int quantity;
  final DateTime requestDate;
  final bool fulfilled;

  BloodRequest({
    required this.bloodGroup,
    required this.quantity,
    required this.requestDate,
    required this.fulfilled,
  });

  factory BloodRequest.fromJson(Map<String, dynamic> json) {
    return BloodRequest(
      bloodGroup: json['bloodGroup'],
      quantity: json['quantity'],
      requestDate: DateTime.parse(json['requestDate']),
      fulfilled: json['fulfilled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bloodGroup': bloodGroup,
      'quantity': quantity,
      'requestDate': requestDate.toIso8601String(),
      'fulfilled': fulfilled,
    };
  }
}
