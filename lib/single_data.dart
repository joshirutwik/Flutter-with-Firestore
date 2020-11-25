import 'package:flutter/material.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

void main()
{
  runApp(HomePage()); 
}
class HomePage extends StatefulWidget {
  //HomePage({Key key,this.title}):super(key:key); 
  //final String title; 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(FontAwesomeIcons.bars), 
          onPressed: null
          ),
        title: Container(  
          alignment:Alignment.center, 
          child: Text("With data"),
        ), 
      actions: <Widget>[
        IconButton( 
          icon:Icon(  
            FontAwesomeIcons.newspaper, 
          ), 
          onPressed: null,
        ), 
      ],
      ),
      body:StreamBuilder(
        stream:Firestore.instance.collection('post').snapshots(),  
         builder: (context,snapshot)
         {
           if(!snapshot.hasData)
           { 
             const Text('Loading'); 
           }
           else 
           {
             return ListView.builder(
               itemCount:snapshot.data.documents.length, 
               itemBuilder: (context,index){ 
                 DocumentSnapshot mypost=snapshot.data.documents[index]; 
                 return Stack(  
                   children: <Widget>[
                     Column( 
                     children:<Widget>[
                       Container( 
                       width:MediaQuery.of(context).size.width, 
                       // this means the maximum width of the entire screen 
                        height: 350.0,
                        child: Padding(  
                          padding:  EdgeInsets.only(top:0,bottom:8.0),
                          child: Material(  
                            color: Colors.white,
                            elevation: 14.0,
                            shadowColor: Color(0x002196f3),
                            child: Center(
                              child:Padding(  
                                padding: EdgeInsets.all(6.0),
                                child: Column (  
                                  children: <Widget>[
                                    Container(  
                                      width: MediaQuery.of(context).size.width,
                                      height: 20.0, 
                                      child:Image.network(
                                      '${mypost['image']}',
                                        fit: BoxFit.fill, 
                                      ),
                                    ), 
                                    SizedBox(height: 10.0,), 
                                    Text('${mypost['title']}'), 
                                    SizedBox(height: 10.0,), 
                                    Text('${mypost['subtitle']}'), 
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                     ), 
                   ],
                     ),
                     Container(  
                       alignment: Alignment.topRight,
                       padding: EdgeInsets.only(
                         top:MediaQuery.of(context).size.height*.047, 
                         left:MediaQuery.of(context).size.height*.52,                      
                       ), 
                       child: Container(  
                         width: MediaQuery.of(context).size.width,
                         child: CircleAvatar(
                            child:Icon(Icons.star,color:Colors.white,size:20.0), 
                            backgroundColor:Color(0xff847bB7A), 
                         ),
                       ),
                     ), 
                   ], 
                 ); 
                }, 
             );
            }
          },
       ) ,
    );
  }
} 