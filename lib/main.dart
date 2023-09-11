import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App",
      home:  HomeState(title: "Camera") ,
    );
  }
}

class HomeState extends StatefulWidget{
  const HomeState({super.key,required this.title});

  final String title;

  @override
  State createState()=>_HomeState();
}

class _HomeState extends State<HomeState>{
  File? _imagePicker;
  dynamic errorImage;

  void _onImageButtonPressed(ImageSource source)async{
    try{
       XFile ? pickImage=await ImagePicker().pickImage(source: source);
        if (pickImage != null) {
        setState(() {
          _imagePicker = File(pickImage.path);
        });
      }
    }catch(e){
      errorImage=e;
    }
  }


Widget displayImage(){
  if(_imagePicker!=null){
    return  Image.file(_imagePicker!);
  }else if(errorImage!=null){
    return  Text("Error Geting Image $errorImage");
  } else{
    return const Text("NoImage");
  }
}

  @override
  Widget build(BuildContext context){

    return  Scaffold(
      appBar: AppBar(title:  Text(widget.title),backgroundColor: Colors.green),
      body: Center(child: displayImage(),),
      floatingActionButton: Row(
        mainAxisAlignment:  MainAxisAlignment.end,
        children:<Widget> [
           Padding(padding: 
                  const EdgeInsets.all(10.0),
                  child:  FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: (){_onImageButtonPressed(ImageSource.camera);},
                      child: const Icon(Icons.photo_camera),
               ),),
                 Padding(padding: 
                  const EdgeInsets.all(10.0),
                  child:  FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: (){_onImageButtonPressed(ImageSource.gallery);},
                      child: const Icon(Icons.photo_library),
               ),)
      ]),
    );
  }
}