import 'dart:convert';
import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;
import 'package:profile/github_user.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({Key key, this.username}) : super(key: key);

  Future<GithubUser> getUser() async {
    final String url = 'https://api.github.com/users/${username}';
    final response = await http.get(url);
    return compute(parseUser, response.body);
  }

  GithubUser parseUser(String responseBody) {
    final parsed = Map<String, dynamic>.from(json.decode(responseBody));
    return GithubUser.fromJson(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GithubUser>(
        future: getUser(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Container(
                    width: 400.0,
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(seconds: 3),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 12.0,
                                  bottom: 8.0,
                                  left: 25.0,
                                  right: 25.0,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 75.0,
                                  backgroundImage:
                                      NetworkImage(snapshot.data.avatarUrl),
                                ),
                              ),
                              Text(
                                snapshot.data.name ?? '',
                                style: TextStyle(fontSize: 22.0),
                              ),
                              if (snapshot.data.bio != null)
                                Text(
                                  snapshot.data.bio,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              if (snapshot.data.company != null)
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  ),
                                  child: ListTile(

                                    leading: Icon(Icons.group),
                                    title: Text(snapshot.data.company, style: TextStyle(fontSize: 15.0)),
                                  ),
                                ),
                              if (snapshot.data.location != null)
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.location_on),
                                    title: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(snapshot.data.location, style: TextStyle(fontSize: 15.0)),
                                    ),
                                  ),
                                ),
                              if (snapshot.data.blog != null &&
                                  snapshot.data.blog.length > 1)
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.web),
                                    title: Text(snapshot.data.blog, style: TextStyle(fontSize: 15.0)),
                                  ),
                                ),
                              if (snapshot.data.email != null)
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.alternate_email),
                                    title: Text(snapshot.data.email, style: TextStyle(fontSize: 15.0)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
