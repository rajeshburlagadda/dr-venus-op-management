import 'package:flutter/material.dart';
import 'patient_list_screen.dart';
import '../database/database_helper.dart';
import '../models/patient_model.dart';

class PatientScreen extends StatefulWidget {
  final Patient? patient;

  const PatientScreen({super.key, this.patient});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();

  String gender = "Male";
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    print(widget.patient);
    print(widget.patient?.name);

    if (widget.patient != null) {
      isEdit = true;

      nameController.text = widget.patient!.name;
      ageController.text = widget.patient!.age.toString();
      mobileController.text = widget.patient!.mobile;
      addressController.text = widget.patient!.address;

      gender = widget.patient!.gender;
    }
  }

  Future<void> savePatient() async {
    final patient = Patient(
      id: widget.patient?.id,
      patientId:
          widget.patient?.patientId ??
          "DV${DateTime.now().millisecondsSinceEpoch}",
      name: nameController.text,
      age: int.tryParse(ageController.text) ?? 0,
      gender: gender,
      mobile: mobileController.text,
      address: addressController.text,
      branch: widget.patient?.branch ?? "",
      doctor: widget.patient?.doctor ?? "",
      date: widget.patient?.date ?? DateTime.now().toString(),
    );

    if (isEdit) {
      await DatabaseHelper.instance.updatePatient(patient.id!, patient.toMap());
    } else {
      await DatabaseHelper.instance.insertPatient(patient.toMap());
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEdit
              ? "Patient Updated Successfully"
              : "Patient Saved Successfully",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Registration"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Patient Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: gender,
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
              ],
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: savePatient,
                child: Text(
                  isEdit ? "UPDATE" : "SAVE",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.list),
                label: const Text(
                  "VIEW PATIENTS",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatientListScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
