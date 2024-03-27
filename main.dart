import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FogBus2 Frameworks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class Service {
  bool isRunning;
  String bindIP;
  int bindPort;

  Service(
      {this.isRunning = false,
      this.bindIP = '127.0.0.1',
      this.bindPort = 5000});
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Service remoteLogger = Service();
  Service actor = Service();
  Service user = Service();
  Service master = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FogBus2 Frameworks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Fog Bus 2 Frameworks',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WhatToDoPage(
                            remoteLogger: remoteLogger,
                            actor: actor,
                            user: user,
                            master: master,
                          )),
                );
              },
              child: Text('Get Started'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatisticsPage(
                            remoteLogger: remoteLogger,
                            actor: actor,
                            user: user,
                            master: master,
                          )),
                );
              },
              child: Text('Current Status'),
            ),
          ],
        ),
      ),
    );
  }
}

class WhatToDoPage extends StatelessWidget {
  final Service remoteLogger;
  final Service actor;
  final Service user;
  final Service master;

  WhatToDoPage(
      {required this.remoteLogger,
      required this.actor,
      required this.user,
      required this.master});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What you want to do?'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'On which you want to work?',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RemoteLoggerPage(remoteLogger)),
                );
              },
              child: remoteLogger.isRunning
                  ? Text('Running')
                  : Text('Remote Logger'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActorPage(actor)),
                );
              },
              child: actor.isRunning ? Text('Running') : Text(' Actor'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage(user)),
                );
              },
              child: user.isRunning ? Text('Running') : Text('User'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MasterPage(master)),
                );
              },
              child: master.isRunning ? Text('Running') : Text(' Master'),
            ),
          ],
        ),
      ),
    );
  }
}

class RemoteLoggerPage extends StatelessWidget {
  final Service remoteLogger;

  RemoteLoggerPage(this.remoteLogger);

  TextEditingController bindIPController = TextEditingController();
  TextEditingController bindPortController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remote Logger'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Remote Logger',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Run Command'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enter IP Address:',
                          ),
                          TextField(
                            controller: bindIPController,
                            decoration: InputDecoration(
                              hintText: 'Enter IP Address',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Enter Port Number:',
                          ),
                          TextField(
                            controller: bindPortController,
                            decoration: InputDecoration(
                              hintText: 'Enter Port Number',
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            remoteLogger.bindIP = bindIPController.text;
                            remoteLogger.bindPort =
                                int.parse(bindPortController.text);
                            remoteLogger.isRunning = true;
                            Navigator.of(context).pop();

                            // Show the Docker command
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Docker Command'),
                                  content: Text(
                                      'docker-compose run --rm --name user fogbus2-user --bindIP ${remoteLogger.bindIP} --remoteLoggerIP ${remoteLogger.bindIP} --remoteLoggerPort ${remoteLogger.bindPort} --masterIP ${remoteLogger.bindIP} --masterPort ${remoteLogger.bindPort + 1} --containerName user --applicationName'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: remoteLogger.isRunning ? Text('Running') : Text('Run'),
            ),
            ElevatedButton(
              onPressed: () {
                remoteLogger.isRunning = false;
              },
              child: Text('Stop Remote Logger'),
            ),
          ],
        ),
      ),
    );
  }
}

class ActorPage extends StatelessWidget {
  final Service actor;

  ActorPage(this.actor);

  TextEditingController bindIPController = TextEditingController();
  TextEditingController bindPortController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Actor',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Run Command'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enter IP Address:',
                          ),
                          TextField(
                            controller: bindIPController,
                            decoration: InputDecoration(
                              hintText: 'Enter IP Address',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Enter Port Number:',
                          ),
                          TextField(
                            controller: bindPortController,
                            decoration: InputDecoration(
                              hintText: 'Enter Port Number',
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            actor.bindIP = bindIPController.text;
                            actor.bindPort = int.parse(bindPortController.text);
                            actor.isRunning = true;
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: actor.isRunning ? Text('Running') : Text('Run'),
            ),
            ElevatedButton(
              onPressed: () {
                actor.isRunning = false;
              },
              child: Text('Stop Actor'),
            ),
            ElevatedButton(
              onPressed: () {
                actor.isRunning = false;
              },
              child: Text('Create Actor'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  final Service user;

  UserPage(this.user);

  TextEditingController bindIPController = TextEditingController();
  TextEditingController bindPortController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Run Command'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enter IP Address:',
                          ),
                          TextField(
                            controller: bindIPController,
                            decoration: InputDecoration(
                              hintText: 'Enter IP Address',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Enter Port Number:',
                          ),
                          TextField(
                            controller: bindPortController,
                            decoration: InputDecoration(
                              hintText: 'Enter Port Number',
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            user.bindIP = bindIPController.text;
                            user.bindPort = int.parse(bindPortController.text);
                            user.isRunning = true;
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: user.isRunning ? Text('Running') : Text('Run'),
            ),
            ElevatedButton(
              onPressed: () {
                user.isRunning = false;
              },
              child: Text('Stop User'),
            ),
            ElevatedButton(
              onPressed: () {
                user.isRunning = false;
              },
              child: Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}

class MasterPage extends StatelessWidget {
  final Service master;

  MasterPage(this.master);

  TextEditingController bindIPController = TextEditingController();
  TextEditingController bindPortController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Master',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Run Command'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enter IP Address:',
                          ),
                          TextField(
                            controller: bindIPController,
                            decoration: InputDecoration(
                              hintText: 'Enter IP Address',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Enter Port Number:',
                          ),
                          TextField(
                            controller: bindPortController,
                            decoration: InputDecoration(
                              hintText: 'Enter Port Number',
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            master.bindIP = bindIPController.text;
                            master.bindPort =
                                int.parse(bindPortController.text);
                            master.isRunning = true;
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: master.isRunning ? Text('Running') : Text('Run'),
            ),
            ElevatedButton(
              onPressed: () {
                master.isRunning = false;
              },
              child: Text('Stop Master'),
            ),
            ElevatedButton(
              onPressed: () {
                master.isRunning = false;
              },
              child: Text('Create Master'),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsPage extends StatelessWidget {
  final Service remoteLogger;
  final Service actor;
  final Service user;
  final Service master;

  StatisticsPage(
      {required this.remoteLogger,
      required this.actor,
      required this.user,
      required this.master});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Currently Running:',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            _buildRunningItem('Remote Logger', remoteLogger.isRunning),
            _buildRunningItem('Actor', actor.isRunning),
            _buildRunningItem('User', user.isRunning),
            _buildRunningItem('Master', master.isRunning),
          ],
        ),
      ),
    );
  }

  Widget _buildRunningItem(String title, bool isRunning) {
    Color statusColor = isRunning ? Colors.green : Colors.red;

    return ListTile(
      title: Text(title),
      trailing: CircleAvatar(
        backgroundColor: statusColor,
        radius: 10,
      ),
    );
  }
}
