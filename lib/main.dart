import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: FactoryEngine(), debugShowCheckedModeBanner: false));

class FactoryEngine extends StatefulWidget {
  @override
  _FactoryEngineState createState() => _FactoryEngineState();
}

class _FactoryEngineState extends State<FactoryEngine> {
  final TextEditingController _token = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  Future<void> _start() async {
    final url = Uri.parse('https://api.github.com/repos/didilamin644-arch/app_maker_pro/dispatches');
    final res = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${_token.text.trim()}',
        'Accept': 'application/vnd.github.v3+json',
      },
      body: '{"event_type": "build_app", "client_payload": {"description": "${_desc.text}"}}',
    );

    if (res.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ نجح الاتصال! بدأ بناء تطبيقك")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("❌ فشل: تأكد من صلاحيات repo و workflow")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("محرك المصنع الحقيقي")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _token, decoration: InputDecoration(labelText: "صق التوكن (ghp_...)")),
            TextField(controller: _desc, decoration: InputDecoration(labelText: "وصف التطبيق")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _start, child: Text("تشغيل المصنع الآن")),
          ],
        ),
      ),
    );
  }
}
