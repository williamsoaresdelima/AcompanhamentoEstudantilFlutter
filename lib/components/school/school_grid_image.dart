

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

class SchoolGridImage extends StatelessWidget {
  const SchoolGridImage(this._image,this.removeImage,{super.key});
  final List<File> _image;
  final Function? removeImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: GridView.count(
              crossAxisCount: 3,
              children: _image
                  .map((image) => Column(
                        children: [
                          Indexer(
                            children: [
                              Indexed(
                                index: 22,
                                child: Image.file(image,
                                    width: 150, height: 100, fit: BoxFit.fill),
                              ),
                              Indexed(
                                index: 100,
                                child: Positioned(
                                  width: 27,
                                  height: 27,
                                  right: 5.0,
                                  top: 5.0,
                                  child: InkResponse(
                                    onTap: () => removeImage!(image),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                  .toList()),
        );
  }
}