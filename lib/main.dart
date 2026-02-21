import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() => runApp(MaterialApp(home: Scaffold(appBar: AppBar(title: Text("المصنع النهائي - الحل الجذري")), body: FactoryBody()), debugShowCheckedModeBanner: false));
class FactoryBody extends StatefulWidget { @override _FactoryBodyState createState() => _FactoryBodyState(); }
class _FactoryBodyState extends State<FactoryBody> {
  final _t = TextEditingController(), _d = TextEditingController();
  bool _l = false;
  _send() async {
    setState(() => _l = true);
    try {
      final String k = _t.text.trim();
      final u = Uri.parse('https://api.github.com/repos/didilamin644-arch/app_maker_pro/contents/lib/main.dart');
      final g = await http.get(u, headers: {'Authorization': 'token $k'});
      final s = jsonDecode(g.body)['sha'];
      final c = base64Encode(utf8.encode("import 'package:flutter/material.dart'; void main() => runApp(MaterialApp(home: Scaffold(appBar: AppBar(title: Text('${_d.text}')), body: Center(child: Icon(Icons.check, size: 100)))));"));
      await http.put(u, headers: {'Authorization': 'token $k'}, body: jsonEncode({"message": "Final Build", "content": c, "sha": s}));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ نجحت العملية! تفقد Actions")));
    } catch (e) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("❌ خطأ: التوكن غير صالح"))); }
    setState(() => _l = false);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20), child: Column(children: [
      TextField(controller: _t, decoration: InputDecoration(labelText: "صق التوكن (Token) الجديد هنا")),
      TextField(controller: _d, decoration: InputDecoration(labelText: "اسم التطبيق (مثلاً: المصحف)")),
      SizedBox(height: 20),
      _l ? CircularProgressIndicator() : ElevatedButton(onPressed: _send, child: Text("صناعة واستخراج الآن"))
    ]));
  }
}
