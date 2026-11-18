import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class AchievementFormPage extends StatefulWidget {
  const AchievementFormPage({super.key});

  @override
  State<AchievementFormPage> createState() => _AchievementFormPageState();
}

class _AchievementFormPageState extends State<AchievementFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _achievementName = "";
  String _organizer = "";
  String _awardCategory = "Gold"; // default
  DateTime? _dateAwarded;

  final _dateController = TextEditingController();
  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  final List<String> _categories = [
    'Gold',
    'Silver',
    'Bronze',
    'Finalist',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Achievement Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Achievement Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Achievement",
                    labelText: "Nama Achievement",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _achievementName = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama Achievement tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Maksimal 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Organizer ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Penyelenggara Lomba",
                    labelText: "Penyelenggara Lomba",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _organizer = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Penyelenggara lomba tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Maksimal 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Achievement",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _awardCategory,
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _awardCategory = newValue!;
                    });
                  },
                ),
              ),

              // === Date Awarded ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _dateController,
                  readOnly: true, // tidak diketik, hanya lewat date picker
                  decoration: InputDecoration(
                    labelText: "Date Awarded",
                    hintText: "Pilih tanggal",
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _dateAwarded ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _dateAwarded = picked;
                        _dateController.text =
                            "${picked.day}/${picked.month}/${picked.year}";
                      });
                    }
                  },
                  validator: (String? value) {
                    if (_dateAwarded == null) {
                      return "Tanggal harus dipilih!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Achievement berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Achievement: $_achievementName'),
                                    Text('Penyelenggara: $_organizer'),
                                    Text(
                                      'Kategori Achievement: $_awardCategory',
                                    ),
                                    Text('Tanggal: ${_dateController.text}'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                    _dateController.clear();
                                    setState(() {
                                      _dateAwarded = null;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
