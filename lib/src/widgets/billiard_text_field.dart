import 'package:flutter/material.dart';

///
/// A wrapper around a [TextFormField]
///
///
class BilliardTextField extends StatefulWidget {

  final String? initialValue;
  final Function valueBinder;

  /// Validates the entered value. Returns an error message
  final FormFieldValidator<String> validator;

  /// If true then the text value is obscured - normally used for passwords
  final bool obscure;

  final String label;

  /// Optional help to be shown with the field
  final String help;

  /// Optional hint to be shown with the field
  final String? hint;

  /// Passed to the [readOnly] parameter in the [TextFormField]
  final bool readOnly;

  final int maxLines;

  const BilliardTextField(
      {Key? key,
      required this.label,
      this.initialValue,
      this.obscure = false,
      this.readOnly = false,
      this.hint,
      this.help = '',
      required this.valueBinder,
      required this.validator,
      this.maxLines = 1})
      : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => BilliardTextFieldState();
}

class BilliardTextFieldState extends State<BilliardTextField> {
  bool previouslyValidated = false;
  bool onChange = false;

  @override
  void initState() {
    previouslyValidated = true;
    if (widget.initialValue == null) {
      previouslyValidated = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formFieldKey = GlobalKey();

    return TextFormField(
      key: formFieldKey,
      initialValue: widget.initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.obscure,
      decoration: InputDecoration(
          labelText: widget.label,
          helperText: widget.help,
          hintText: widget.hint),
      validator: (v) {
        if (previouslyValidated || !onChange) {
          onChange = false;
          previouslyValidated = true;
          return widget.validator(v);
        } else {
          onChange = false;
        }
        return null;
      },
      onChanged: (v) {
        widget.valueBinder(v);
        onChange = true;
      },
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
    );
  }
}

@immutable
class BilliardTextFieldTheme extends ThemeExtension<BilliardTextFieldTheme> {
  final double width;

  const BilliardTextFieldTheme({this.width = 200});

  @override
  ThemeExtension<BilliardTextFieldTheme> copyWith({double? width}) {
    return BilliardTextFieldTheme(width: width ?? 200);
  }

  @override
  ThemeExtension<BilliardTextFieldTheme> lerp(
      ThemeExtension<BilliardTextFieldTheme>? other, double t) {
    return this;
  }
}
