import 'package:flutter/material.dart';
import 'package:flutter_Wtisc/data/models/user.dart';

import '../../data/models/users.dart';
import '../../data/repositories/user_repositories.dart';

class HomeScreen extends StatelessWidget {
  final repositories = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.camera), onPressed: () {}),
      title: Text(
        'Fotinhas',
        style: TextStyle(
            fontSize: 21.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: <Widget>[IconButton(icon: Icon(Icons.send), onPressed: () {})],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Container(
          height: 120.0,
          color: Colors.grey.shade200,
          child: _buildStories(),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildFeedItem(context: context);
              }),
        ),
      ],
    );
  }

  Widget _buildStories() {
    return FutureBuilder(
      future: repositories.getUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final Users data = snapshot.data;
          final List<User> users = data.users;
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users.elementAt(index);
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      radius: 33.0,
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                  ),
                  Text(
                    user.firstName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildFeedItem({@required BuildContext context}) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(),
              SizedBox(width: 10.0),
              Text(
                'nome_do_usuario',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: Image(
                fit: BoxFit.cover,
                image: NetworkImage('https://picsum.photos/400'))),
      ],
    );
  }
	
        
}
