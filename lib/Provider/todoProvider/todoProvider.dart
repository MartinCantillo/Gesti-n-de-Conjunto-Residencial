import 'package:flutter_riverpod/flutter_riverpod.dart';


enum TodoFilter { all, completed, pending, process ,rejected, Pendiente, }

final todoFilterProvider = StateProvider<TodoFilter>((ref) {
  return TodoFilter.all;
});

