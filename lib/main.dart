import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: AlMasnaaRealEngine(), debugShowCheckedModeBanner: false));

class AlMasnaaRealEngine extends StatefulWidget {
  @override
  _AlMasnaaRealEngineState createState() => _AlMasnaaRealEngineState();
}

class _AlMasnaaRealEngineState extends State<AlMasnaaRealEngine> {
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future<void> _startProduction() async {
    final token = _tokenController.text.trim();
    // الرابط الحقيقي لإرسال أمر البناء لـ GitHub
    final url = Uri.parse('https://api.github.com/repos/didilamin644-arch/app_maker_pro/dispatches');
    
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/vnd.github.v3+json',
      },
      body: '{"event_type": "build_app", "client_payload": {"description": "${_descController.text}"}}',
    );

    if (response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ نجح الاتصال! بدأ المصنع بالعمل في GitHub")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("❌ فشل: تأكد من صلاحيات التوكن (repo & workflow)")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("المصنع - المحرك الحقيقي")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _tokenController, decoration: InputDecoration(labelText: "صق التوكن هنا")),
            TextField(controller: _descController, decoration: InputDecoration(labelText: "وصف التطبيق")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _startProduction, child: Text("تشغيل المصنع الآن")),
          ],
        ),
      ),
    );
  }
}
