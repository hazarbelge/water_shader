import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_shader/ui/widgets/index.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    late Matrix4 matrix4;
    final TransformationController _transformationController = TransformationController();
    return CustomScaffold(
      colors: const <Color>[Colors.black, Colors.black],
      padding: EdgeInsets.zero,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: height,
            width: double.infinity,
            child: InteractiveViewer(
              panEnabled: false,
              boundaryMargin: EdgeInsets.zero,
              minScale: 0.5,
              maxScale: 4,
              transformationController: _transformationController,
              onInteractionStart: (ScaleStartDetails details) {
                matrix4 = _transformationController.value;
              },
              onInteractionEnd: (ScaleEndDetails details) {
                _transformationController.value = matrix4;
              },
              child: Center(
                child: CustomCachedNetworkImage(
                  imageUrl: imageUrl,
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: InkWell(
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                size: 32,
              ),
              onTap: Get.back,
            ),
          ),
        ],
      ),
    );
  }
}
