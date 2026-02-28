import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(home: FactoryEngine(), debugShowCheckedModeBanner: false));

class FactoryEngine extends StatelessWidget {
  const FactoryEngine({super.key});

  Future<void> startBuild(BuildContext context) async {
    final url = Uri.parse('https://api.github.com/repos/didilamin644-arch/app_maker_pro/dispatches');
    final res = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/vnd.github.v3+json',
      'Content-Type': 'application/json',
    }, body: jsonEncode({"event_type": "build_app"}));

    if (res.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ بدأ البناء الآن! راقب GitHub Actions")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("❌ فشل: ${res.statusCode}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المصنع النهائي - DIDILAMIN")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => startBuild(context),
          child: const Text("ابدأ صناعة التطبيق المحدث"),
        ),
      ),
    );
  }
}
