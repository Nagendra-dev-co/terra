import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATS Document Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF0F4FF),
      ),
      home: const ATSDocumentScreen(),
    );
  }
}

class ATSDocumentScreen extends StatefulWidget {
  const ATSDocumentScreen({super.key});

  @override
  State<ATSDocumentScreen> createState() => _ATSDocumentScreenState();
}

class _ATSDocumentScreenState extends State<ATSDocumentScreen> {
  String? selectedCompany;
  String? selectedDocType;
  PlatformFile? file;
  bool isSubmitting = false;

  final List<String> companies = [
    'Apple Inc.',
    'Google',
    'Microsoft',
    'Amazon',
    'Meta',
    'Netflix',
    'Tesla',
    'IBM'
  ];

  final List<String> documentTypes = [
    'Job Description',
    'Resume'
  ];

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        file = result.files.first;
      });
    }
  }

  void removeFile() {
    setState(() {
      file = null;
    });
  }

  Future<void> handleSubmit() async {
    if (selectedCompany == null || selectedDocType == null || file == null) return;

    setState(() {
      isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isSubmitting = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
      setState(() {
        file = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = selectedCompany != null && selectedDocType != null && file != null;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'ATS Document Management',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Select a company and document type to proceed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Company Dropdown
                        const Text(
                          'Select Company',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedCompany,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          hint: const Text('Choose a company'),
                          items: companies.map((String company) {
                            return DropdownMenuItem<String>(
                              value: company,
                              child: Text(company),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedCompany = value;
                            });
                          },
                        ),
                        const SizedBox(height: 24),

                        // Document Type Dropdown
                        const Text(
                          'Select Document Type',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedDocType,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          hint: const Text('Choose document type'),
                          items: documentTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedDocType = value;
                              file = null;
                            });
                          },
                        ),
                        const SizedBox(height: 24),

                        // File Upload Section
                        if (selectedDocType != null) ...[
                          const Text(
                            'Upload Document (PDF)',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (file == null)
                            InkWell(
                              onTap: pickFile,
                              child: Container(
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFD1D5DB),
                                    width: 2,
                                    style: BorderStyle.dashed,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.upload_file,
                                      size: 48,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Tap to upload your ${selectedDocType?.toLowerCase()} PDF file',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEBF5FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.description,
                                    color: Color(0xFF2563EB),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          file!.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF1F2937),
                                          ),
                                        ),
                                        Text(
                                          '${(file!.size / 1024 / 1024).toStringAsFixed(2)} MB',
                                          style: const TextStyle(
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: removeFile,
                                    color: const Color(0xFF9CA3AF),
                                  ),
                                ],
                              ),
                            ),
                        ],

                        // Selection Summary
                        if (selectedCompany != null ||
                            selectedDocType != null ||
                            file != null) ...[
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF5FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your Selection:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1E3A8A),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (selectedCompany != null)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.business,
                                        size: 20,
                                        color: Color(0xFF1E3A8A),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Company: $selectedCompany',
                                        style: const TextStyle(
                                          color: Color(0xFF1E3A8A),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (selectedDocType != null) ...[
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.description,
                                        size: 20,
                                        color: Color(0xFF1E3A8A),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Document Type: $selectedDocType',
                                        style: const TextStyle(
                                          color: Color(0xFF1E3A8A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (file != null) ...[
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        size: 20,
                                        color: Color(0xFF1E3A8A),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'File: ${file!.name}',
                                        style: const TextStyle(
                                          color: Color(0xFF1E3A8A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],

                        // Submit Button
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: isFormValid && !isSubmitting
                              ? handleSubmit
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFormValid
                                ? const Color(0xFF2563EB)
                                : const Color(0xFF9CA3AF),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isSubmitting) ...[
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                isSubmitting ? 'Submitting...' : 'Submit',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}