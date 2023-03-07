import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  List projectData = [];

  @override
  void initState() {
    super.initState();
    getProjects();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    getProjects();
                  });
                },
                icon: Icon(Icons.refresh))
          ],
          title: Text('รายชื่อโครงการ'),
          bottom: PreferredSize(
            child: Container(
              alignment: Alignment.centerLeft,
              color: Colors.white,
              constraints: BoxConstraints.expand(height: 50),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('รายชื่อโครงการ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              ),
            ),
            preferredSize: Size(50, 50),
          ),
        ),
        body: projectList());
  }

  Widget projectList() {
    return ListView.builder(
        itemCount: projectData.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(
                Icons.insert_drive_file_outlined,
                size: 50,
              ),
              title: Text('${projectData[index]['p_name']}'),
              subtitle:
                  Text('A sufficiently long subtitle warrants three lines.'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
                color: Colors.blue,
              ),
            ),
          );
        });
  }

  Future getProjects() async {
    var url = Uri.http(
        'dekdee2.informatics.buu.ac.th:9080', '/team0/api/getAllProjects');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    // print(result);
    setState(() {
      projectData = jsonDecode(result);
    });
  }
}
