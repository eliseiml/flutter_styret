import 'package:flutter/material.dart';
import 'package:flutter_styret_app/utilites/colors.dart';

Widget scalableImageView(String imageUrl) {
  TransformationController transformationController =
      TransformationController();
  TapDownDetails tapDownDetails;
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onDoubleTapDown: (details) {
      tapDownDetails = details;
    },
    onDoubleTap: () {
      if (transformationController.value != Matrix4.identity()) {
        transformationController.value = Matrix4.identity();
      } else {
        final position = tapDownDetails.localPosition;
        transformationController.value = Matrix4.identity()
          ..translate(-position.dx * 2, -position.dy * 2)
          ..scale(3.0);
      }
    },
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: imageUrl != ''
          ? InteractiveViewer(
              transformationController: transformationController,
              child: Image.network(
                imageUrl,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.error,
                    size: 80,
                  );
                },
              ),
            )
          : Icon(
              Icons.broken_image_outlined,
              size: 180,
              color: kInactiveTextColor,
            ),
    ),
  );
}
