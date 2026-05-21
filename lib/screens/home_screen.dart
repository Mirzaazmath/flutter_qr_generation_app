import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController qrController = TextEditingController();

  String qrData = "";

  @override
  void dispose() {
    qrController.dispose();
    super.dispose();
  }

  void generateQr() {
    setState(() {
      qrData = qrController.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F8),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "QR Generator",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: Colors.black87,
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 40,
            children: [
              /// TextField
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: TextField(
                  controller: qrController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),

                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter text or website URL",
                    prefixIcon: Icon(Icons.qr_code_2_rounded),
                  ),

                  onChanged: (_) => generateQr(),
                  //onSubmitted: (_) => generateQr(),
                ),
              ),

              /// QR Section
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
                height: qrData.isEmpty ? 120 : width * 0.75,

                child: Center(
                  child: qrData.isEmpty
                      ? const Text(
                          "Enter data to Generate QR...!",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      : AnimatedScale(
                          scale: 1,
                          duration: const Duration(milliseconds: 400),

                          child: AnimatedOpacity(
                            opacity: 1,
                            duration: const Duration(milliseconds: 400),

                            child: Container(
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                gradient: const LinearGradient(
                                  colors: [Colors.white, Color(0xFFF1F5F9)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.indigo.withOpacity(0.15),
                                    blurRadius: 30,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: QrImageView(
                                data: qrData,
                                size: width * 0.58,
                              ),
                            ),
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
