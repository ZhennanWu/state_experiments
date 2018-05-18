import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_exploration/common/models/cart.dart';
import 'package:reactive_exploration/common/widgets/cart_button.dart';
import 'package:reactive_exploration/src/bloc/main.dart' as bloc;
import 'package:reactive_exploration/src/redux/main.dart' as redux;
import 'package:reactive_exploration/src/scoped/complete.dart' as scoped_model;
import 'package:reactive_exploration/src/value_notifier/main.dart'
    as value_notifier;
import 'package:reactive_exploration/src/vanilla/main.dart' as vanilla;

void main() {
  testWidgets('vanilla', (WidgetTester tester) async {
    final app = vanilla.MyApp();

    await _performSmokeTest(tester, app);
  });

  testWidgets('value_notifier', (WidgetTester tester) async {
    final cartObservable = value_notifier.CartObservable(Cart());
    final app = value_notifier.MyApp(
      cartObservable: cartObservable,
    );

    await _performSmokeTest(tester, app);
  });

  testWidgets('scoped_model', (WidgetTester tester) async {
    final app = scoped_model.MyApp();

    await _performSmokeTest(tester, app);
  });

  testWidgets('redux', (WidgetTester tester) async {
    final app = redux.MyApp();

    await _performSmokeTest(tester, app);
  });

  testWidgets('bloc', (WidgetTester tester) async {
    final app = bloc.MyApp();

    await _performSmokeTest(tester, app);
  });
}

Future _performSmokeTest(WidgetTester tester, Widget app) async {
  await tester.pumpWidget(app);

  await tester.tap(find.byType(CartButton));

  await tester.pumpAndSettle();

  expect(tester.any(find.text("Empty")), isTrue);
}
