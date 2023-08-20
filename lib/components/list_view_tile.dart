import 'package:flutter/material.dart';

Widget TileListView(String name, int score) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar.jpeg'),
        ),
        title: Text(
          '$name',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          ' score: $score',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
