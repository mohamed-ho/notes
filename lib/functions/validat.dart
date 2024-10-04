import 'package:note/constant/string_const.dart';

validateTextField(String val, int max, int min) {
  if (val.isEmpty) {
    return emptyText;
  } else if (val.length > max)
    return '$maxText $max';
  else if (val.length < min) return '$minText $min';
}
