import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.imageBuilder,
    this.filterQuality = FilterQuality.low,
    this.fit,
    this.width,
    this.height,
    this.errorWidget,
    this.placeholder,
    this.colorBlendMode,
  });

  final String imageUrl;
  final Widget Function(BuildContext context, ImageProvider<Object> imageProvider)? imageBuilder;
  final FilterQuality filterQuality;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final Widget Function(BuildContext, String)? placeholder;
  final BlendMode? colorBlendMode;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: imageBuilder,
      filterQuality: filterQuality,
      fit: fit,
      width: width,
      height: height,
      placeholder: placeholder,
      colorBlendMode: colorBlendMode,
      errorWidget: (BuildContext context, String url, dynamic error) {
        debugPrint('Error loading image: $error at $imageUrl trying again first time...');
        return CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: imageBuilder,
          filterQuality: filterQuality,
          fit: fit,
          width: width,
          height: height,
          placeholder: placeholder,
          colorBlendMode: colorBlendMode,
          errorWidget: (BuildContext context, String url, dynamic error) {
            debugPrint('Error loading image: $error at $imageUrl trying again second time...');
            return CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: imageBuilder,
              filterQuality: filterQuality,
              fit: fit,
              width: width,
              height: height,
              placeholder: placeholder,
              colorBlendMode: colorBlendMode,
              errorWidget: (BuildContext context, String url, dynamic error) {
                debugPrint('Error loading image: $error at $imageUrl trying again third time...');
                return CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: imageBuilder,
                  filterQuality: filterQuality,
                  fit: fit,
                  width: width,
                  height: height,
                  placeholder: placeholder,
                  colorBlendMode: colorBlendMode,
                  errorWidget: errorWidget != null
                      ? (BuildContext context, String url, dynamic error) {
                          debugPrint('Error loading image: $error at $imageUrl returning error widget...');
                          return errorWidget!;
                        }
                      : null,
                );
              },
            );
          },
        );
      },
    );
  }
}
