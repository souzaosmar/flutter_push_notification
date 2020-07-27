import 'package:push/push_notification/strategy/i_push_strategy.dart';
import 'package:get/get.dart';

class InformacaoProcessualStrategy implements IPushStrategy {
  @override
  void execute(Map<String, dynamic> pushPayload) {
    print('InformacaoProcessualStrategy: $pushPayload');
  }
}
