class Patient {
  int? id;
  String patientId;
  String name;
  int age;
  String gender;
  String mobile;
  String address;
  String branch;
  String doctor;
  String date;

  Patient({
    this.id,
    required this.patientId,
    required this.name,
    required this.age,
    required this.gender,
    required this.mobile,
    required this.address,
    required this.branch,
    required this.doctor,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'name': name,
      'age': age,
      'gender': gender,
      'mobile': mobile,
      'address': address,
      'branch': branch,
      'doctor': doctor,
      'date': date,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      patientId: map['patientId'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      mobile: map['mobile'],
      address: map['address'],
      branch: map['branch'],
      doctor: map['doctor'],
      date: map['date'],
    );
  }
}
