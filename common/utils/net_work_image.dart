import 'package:flutter/material.dart';

class TMNetworkImage extends StatefulWidget {
  TMNetworkImage({super.key, this.url, this.placeholder, this.error});
  String? url;
  Widget? placeholder;
  Widget? error;
  @override
  State<TMNetworkImage> createState() => _TMNetworkImageState();
}

class _TMNetworkImageState extends State<TMNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        widget.url ?? "",
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: widget.placeholder ?? CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return widget.error ?? Icon(Icons.error);
        },
      ),
    );
  }
}
