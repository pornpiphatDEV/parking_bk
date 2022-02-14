import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import '../constants/addressAPI.dart';

IO.Socket socket = IO.io('${addressAPI.news_urlAPI2}', <String, dynamic>{
  'transports': ['websocket'],
  'autoConnect': true,
});

void contentToServer() async {
  // IO.Socket socket;

  try {
    socket = IO.io('${addressAPI.news_urlAPI2}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.on('connect', (_) => print('connect: ${socket.id}'));
    socket.on('bookingrights', (data) {
      print(data);
    });

    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  } catch (e) {
    print(e);
  }
}
