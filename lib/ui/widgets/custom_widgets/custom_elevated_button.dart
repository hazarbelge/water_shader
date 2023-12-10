import 'package:flutter/material.dart';
import 'package:water_shader/core/theme/index.dart';
import 'package:water_shader/ui/widgets/index.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.colors,
    this.text,
    this.borderRadius = 30,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1,
    this.elevation = 0,
    this.paddings = const EdgeInsets.symmetric(horizontal: 20),
    this.child,
    this.prefix,
    this.suffix,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.height = 65,
  });

  final List<Color>? colors;
  final String? text;
  final double borderRadius;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final Color borderColor;
  final double borderWidth;
  final double elevation;
  final EdgeInsets paddings;
  final Widget? child;
  final Widget? prefix;
  final Widget? suffix;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      color: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: colors == null || colors!.length == 1 ? colors?.first : null,
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: colors == null || colors!.length >= 2
              ? LinearGradient(
                  colors: colors ??
                      <Color>[
                        ThemeColors.secondaryColor,
                        ThemeColors.primaryColor,
                      ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        clipBehavior: Clip.none,
        child: BaseButton(
          focusNode: focusNode,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((Set<MaterialState> states) => elevation),
            backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => Colors.transparent),
            foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => Colors.transparent),
            surfaceTintColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => Colors.transparent),
            shape: MaterialStateProperty.resolveWith((Set<MaterialState> states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))),
            padding: MaterialStateProperty.resolveWith((Set<MaterialState> states) => paddings),
          ),
          child: child ??
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  prefix ?? const SizedBox(),
                  const Spacer(),
                  Expanded(
                    flex: 10,
                    child: Text(
                      text ?? "",
                      style: textStyle ??
                          TextStyles.buttonText.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                      textAlign: textAlign,
                    ),
                  ),
                  const Spacer(),
                  suffix ?? const SizedBox(),
                ],
              ),
        ),
      ),
    );
  }
}
