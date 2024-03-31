
import 'package:flutter/material.dart';

navigatorSimple(context,destination){
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            return destination ;
          }));
}
navigatorDelete(context,destination){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context){
    return destination;
  }), (route) => false);
}