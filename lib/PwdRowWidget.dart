import 'package:flutter/material.dart';

class Pwd {
  String name;
  String url;
  String email;
  String password;
  String notes;

  Pwd({this.name, this.url, this.email, this.password, this.notes});

  String toString() {
    return '${this.name} - ${this.url} - ${this.email} - ${this.password} - ${this.notes}';
  }

  String toJson() {
    return '{"name": "$name", "url": "$url", "email": "$email", "password": "$password", "notes": "$notes"}';
  }

  factory Pwd.fromJson(Map<String, dynamic> json) {
    return Pwd(
      name: json['name'] as String,
      url: json['url'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      notes: json['notes'] as String,
    );
  }
}

class PwdRowWidget extends StatefulWidget {
  final Pwd pwd;
  PwdRowWidget({Key key, this.pwd}) : super(key: key);

  @override
  _PwdRowWidgetState createState() => _PwdRowWidgetState();
}

class _PwdRowWidgetState extends State<PwdRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      color: Color(0xFFFFFF),
      height: 80,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                (widget.pwd != null) ? widget.pwd.name ?? '' : '',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                (widget.pwd != null) ? widget.pwd.email ?? '' : '',
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
