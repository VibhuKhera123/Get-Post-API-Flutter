import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loginapi/url_constants.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<dynamic>> _futureUsers;

  Future<List<dynamic>> getUsers() async {
  final response = await http.get(Uri.parse(getuser));

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    return data;
  } else {
    throw Exception('Failed to load users');
  }
}

  @override
  void initState() {
    super.initState();
    _futureUsers = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: _futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['avatar']),
                    ),
                    title: Text('${user['first_name']} ${user['last_name']}'),
                    subtitle: Text(user['email']),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
