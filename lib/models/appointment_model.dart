class Appointment {
  String? id;
  String? donorId;
  DateTime? requestedDate;
  String? status;
  DateTime? appointmentDate;
  String? location;
  String? description;
  String? adminId;

  Appointment({
    this.id,
    this.donorId,
    this.requestedDate,
    this.status,
    this.appointmentDate,
    this.location,
    this.description,
    this.adminId,
  });

  Appointment.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        donorId = json['donorId'],
        status = json['status'],
        location = json['location'],
        description = json['description'],
        adminId = json['adminId'] ?? "",
        requestedDate = _parseDateTime(json['requestedDate']),
        appointmentDate = _parseDateTime(json['appointmentDate']);

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'donorId': donorId,
      'requestedDate': requestedDate?.toIso8601String(),
      'status': status,
      'appointmentDate': appointmentDate?.toIso8601String(),
      'location': location,
      'description': description,
      'adminId': adminId,
    };
  }

  static DateTime? _parseDateTime(dynamic dateTimeString) {
    if (dateTimeString == null) {
      return null;
    }
    if (dateTimeString is DateTime) {
      return dateTimeString;
    }
    if (dateTimeString is String) {
      // Try parsing different date formats here based on the actual JSON data format
      try {
        return DateTime.parse(dateTimeString);
      } catch (e) {
        // Handle any parsing errors or different date formats accordingly
        print("Error parsing date: $e");
        return null;
      }
    }
    return null;
  }
}
