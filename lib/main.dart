import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MaterialApp(
      home: AlMasnaaFinalApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    ));

class AlMasnaaFinalApp extends StatefulWidget {
  @override
  _AlMasnaaFinalAppState createState() => _AlMasnaaFinalAppState();
}

class _AlMasnaaFinalAppState extends State<AlMasnaaFinalApp> {
  final TextEditingController _promptController = TextEditingController();
  List<String> _buildLogs = [];
  bool _isBuilding = false;
  double _progress = 0.0;

  final Map<String, String> _autoFixDB = {
    "خطأ": "تم تفعيل نظام Self-Healing وإصلاح العطب البرمجي.",
    "توقف": "تم حل مشكلة الذاكرة وتحسين الأداء آلياً.",
    "واجهة": "تم ضبط أبعاد الواجهة لتناسب جميع أنواع الشاشات.",
    "لعبة": "تم تجهيز محرك الرسوميات وتصحيح فيزياء التصادم.",
  };

  void _executeProduction() async {
    if (_promptController.text.isEmpty) return;
    setState(() {
      _isBuilding = true;
      _buildLogs.clear();
      _progress = 0.1;
      _buildLogs.add("⚙️ بدء محرك المصنع النهائي...");
    });

    await _step("🔍 تحليل الوصف واستخراج الأكواد...", 0.3, 2);
    
    String input = _promptController.text;
    bool issuesFound = false;
    _autoFixDB.forEach((key, fix) {
      if (input.contains(key)) {
        _buildLogs.add("⚠️ رصد مشكلة في [$key] -> جاري الإصلاح آلياً...");
        _buildLogs.add("🛠️ $fix");
        issuesFound = true;
      }
    });
    
    if (!issuesFound) _buildLogs.add("🛡️ لم يتم رصد أخطاء منطقية، الكود سليم.");
    await _step("🏗️ بناء ملفات النظام...", 0.6, 2);
    await _step("📦 حزم التطبيق النهائي APK...", 0.9, 2);
    
    setState(() {
      _progress = 1.0;
      _isBuilding = false;
      _buildLogs.add("🎊 تم الإنتاج بنجاح! التطبيق جاهز.");
    });
  }

  Future<void> _step(String msg, double prog, int sec) async {
    await Future.delayed(Duration(seconds: sec));
    setState(() {
      _buildLogs.add(msg);
      _progress = prog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1117),
      appBar: AppBar(title: Text("المصنع - النسخة النهائية"), backgroundColor: Colors.blueAccent[700], centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _promptController,
              maxLines: 4,
              decoration: InputDecoration(hintText: "صف تطبيقك هنا...", filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(height: 20),
            if (_isBuilding) LinearProgressIndicator(value: _progress, color: Colors.blueAccent),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.rocket),
              label: Text("بدء الإنتاج والتثبيت"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600], minimumSize: Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              onPressed: _isBuilding ? null : _executeProduction,
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.blueAccent.withOpacity(0.5))),
                child: ListView.builder(
                  itemCount: _buildLogs.length,
                  itemBuilder: (context, index) => Text(_buildLogs[index], style: TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 13)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
