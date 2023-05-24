import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/School.dart';
import '../../providers/school_provider.dart';
import '../../routes/route.dart';

class SchoolListItens extends StatefulWidget {
  const SchoolListItens(this.school, this.contexts, {super.key});
 final School school;
 final BuildContext contexts;

  @override
  State<SchoolListItens> createState() => _SchoolListItensState();
}

class _SchoolListItensState extends State<SchoolListItens> {
  @override
  Widget build(BuildContext context) {
    double elevation = 4.0;
    double scale = 1.0;
    Offset translate = Offset(0,0);

    final provider = Provider.of<SchoolProvider>(context);
    return  InkWell(
              child: 
              
              
              ListTile(
                    leading: Transform.translate(
                              offset: translate ,        
                              child: Transform.scale(
                                scale: scale,
                                child: Material(        
                                  elevation: elevation,        
                                  child: 
                                    Image.network("https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg"),              
                                  ),
                                ),
                              ),
                    title: Text("${widget.school.name}"),
                    subtitle: Text("Particular"),
                    onTap: () {
                      Navigator.of(widget.contexts).pushNamed(
                        Routes.schoolShowScreen,
                        arguments: widget.school);
                    },
                    
                  ),
                  onHover: (isHovering) {
                    print(isHovering);
                  if (isHovering) {
                         setState((){
                            elevation = 20.0;     
                            scale = 2.0;
                            translate = Offset(20,20);
                          });
                  } else {
                         setState((){
                          elevation = 4.0; 
                          scale = 1.0;
                          translate = Offset(0,0);
                        });
                  }
                }

          );
   
  }
}