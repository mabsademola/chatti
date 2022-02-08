import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Imageviewer extends StatefulWidget {
  const Imageviewer({
    Key key,
    this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  _ImageviewerState createState() => _ImageviewerState();
}

class _ImageviewerState extends State<Imageviewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.imageUrl),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 1.5,
                  );
                },
                itemCount: 1,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 10.0,
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes,
                    ),
                  ),
                ),
                backgroundDecoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
              Positioned(
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        // height: 25,
                        //  width: 50,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
