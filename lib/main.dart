import 'package:flutter/material.dart';

void main() {
  List loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Ut enim ad minim veniam, quis nostrud exercitation ullamco".split(" ");
  List people = ["Dmytro", "Egor", "Maria", "Roman", "Anthony", "Olga", "Kristina", "Alexandra", "Mikita", "Maxym", "Egor", "Alexandr"];
  int n = 0;
  
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(
        items: List<ListItem>.generate(
        12, (i) => i % 13 == 0
            ? HeadingItem('Group $i')
            : MessageItem(people[i], loremIpsum[n++] + " " + loremIpsum[n++]),
        ),
      ),
    },
  ));
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);  
  Widget buildSubtitle(BuildContext context);
}

class SecondRoute extends StatelessWidget {
  final Widget data;
  SecondRoute({ required this.data });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message details "),
      ),
      body: Center (
        child: data
      )
    );
  }
}

class MyApp extends StatelessWidget {
  final List<ListItem> items;
  const MyApp({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const title = 'Tap to any chat';

    return MaterialApp (
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute (
                    builder: (context) => SecondRoute( data: item.buildSubtitle(context))
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class MessageItem implements ListItem {
  final String people;
  final String message;

  MessageItem(this.people, this.message);

  @override
  Widget buildTitle(BuildContext context) => Text(people);

  @override
  Widget buildSubtitle(BuildContext context) => Text(message);
}

class HeadingItem implements ListItem {
  final String heading;
  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}