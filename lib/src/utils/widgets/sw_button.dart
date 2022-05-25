import 'package:flutter/material.dart';

import '../style/app_color.dart';

enum ButtonActionType { primary, secundary, neutral }

enum ButtonStatus { active, inactive, progress }

class SWButton extends StatelessWidget {
  const SWButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.elevated = false,
      this.actionType = ButtonActionType.primary,
      this.icon,
      this.alignment = Alignment.center,
      this.streamStatus})
      : super(key: key);

  const SWButton.elevated(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.icon,
      this.alignment = Alignment.center,
      this.streamStatus})
      : elevated = true,
        actionType = ButtonActionType.primary,
        super(key: key);

  const SWButton.flat(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.icon,
      this.alignment = Alignment.center,
      this.streamStatus})
      : elevated = false,
        actionType = ButtonActionType.primary,
        super(key: key);

  const SWButton.elevatedNegative(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.icon,
      this.alignment = Alignment.center,
      this.streamStatus})
      : elevated = true,
        actionType = ButtonActionType.secundary,
        super(key: key);

  const SWButton.flatNegative(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.icon,
      this.alignment = Alignment.center,
      this.streamStatus})
      : elevated = false,
        actionType = ButtonActionType.secundary,
        super(key: key);

  const SWButton.elevatedNeutral(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.icon,
      this.alignment = Alignment.center,
      this.streamStatus})
      : elevated = true,
        actionType = ButtonActionType.neutral,
        super(key: key);

  const SWButton.flatNeutral(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.icon,
      this.alignment = Alignment.center,
      this.streamStatus})
      : elevated = false,
        actionType = ButtonActionType.neutral,
        super(key: key);

  final Widget child;
  final Function()? onPressed;
  final bool elevated;
  final ButtonActionType actionType;
  final Widget? icon;
  final AlignmentGeometry? alignment;
  final Stream<ButtonStatus>? streamStatus;

  @override
  Widget build(BuildContext context) {
    if (streamStatus == null) {
      return elevated ? _generateElevatedButton() : _generateTextButton();
    }

    return StreamBuilder<ButtonStatus>(
        initialData: ButtonStatus.inactive,
        stream: streamStatus,
        builder: (context, snapshot) {
          if (snapshot.data == ButtonStatus.progress) {
            return const Center(child: CircularProgressIndicator());
          }
          return elevated
              ? _generateElevatedButton(snapshot.data)
              : _generateTextButton(snapshot.data);
        });
  }

  Widget _generateTextButton([ButtonStatus? status]) {
    if (icon != null) {
      return TextButton.icon(
          icon: icon!,
          onPressed: evaluatedButtonStatus(status),
          label: child,
          style: _getTextButtonStyle());
    }
    return TextButton(
        onPressed: evaluatedButtonStatus(status),
        style: _getTextButtonStyle(),
        child: child);
  }

  Widget _generateElevatedButton([ButtonStatus? status]) {
    if (icon != null) {
      return ElevatedButton.icon(
          icon: icon!,
          onPressed: evaluatedButtonStatus(status),
          label: child,
          style: _getElevatedButtonStyle());
    }
    return ElevatedButton(
        onPressed: evaluatedButtonStatus(status),
        style: _getElevatedButtonStyle(),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: child,
        ));
  }

  Function()? evaluatedButtonStatus([ButtonStatus? status]) {
    if (status != null) {
      return status == ButtonStatus.inactive ? null : onPressed;
    }
    return onPressed;
  }

  ButtonStyle _getTextButtonStyle() {
    switch (actionType) {
      case ButtonActionType.primary:
        return ButtonStyle(
          alignment: alignment,
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.primary.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.disableButtonColor;
              }
              return AppColor.primary;
            },
          ),
        );
      case ButtonActionType.secundary:
        return ButtonStyle(
          alignment: alignment,
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.secundary.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.disableButtonColor;
              }
              return AppColor.secundary;
            },
          ),
        );
      case ButtonActionType.neutral:
        return ButtonStyle(
          alignment: alignment,
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.grey.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.disableButtonColor;
              }
              return AppColor.grey;
            },
          ),
        );
      default:
        return ButtonStyle(
          alignment: alignment,
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.grey.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.disableButtonColor;
              }
              return AppColor.grey;
            },
          ),
        );
    }
  }

  ButtonStyle _getElevatedButtonStyle() {
    switch (actionType) {
      case ButtonActionType.primary:
        return ButtonStyle(
          alignment: alignment,
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.primary.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.disableButtonColor;
              }
              return AppColor.primary;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.white.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.textGreyColor;
              }
              return AppColor.white;
            },
          ),
        );
      case ButtonActionType.secundary:
        return ButtonStyle(
          alignment: alignment,
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.secundary.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.disableButtonColor;
              }
              return AppColor.secundary;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.white.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.textGreyColor;
              }
              return AppColor.white;
            },
          ),
        );
      case ButtonActionType.neutral:
        return ButtonStyle(
          alignment: alignment,
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.disableButtonColor;
              }
              return Colors.white;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.textGreyColor.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.textGreyColor;
              }
              return AppColor.textGreyColor;
            },
          ),
        );
      default:
        return ButtonStyle(
          alignment: alignment,
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColor.grey.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return AppColor.grey;
              }
              return AppColor.grey;
            },
          ),
        );
    }
  }
}
