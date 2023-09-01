import 'package:flutter/material.dart';

const navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Accueil',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.music_note),
    activeIcon: Icon(Icons.music_note_rounded),
    label: 'Répétitions',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.star),
    activeIcon: Icon(Icons.star_rounded),
    label: 'Concerts',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.library_music),
    activeIcon: Icon(Icons.library_music_rounded),
    label: 'Partitions',
  ),
];
