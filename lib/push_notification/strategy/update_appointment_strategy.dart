import 'package:push/push_notification/strategy/i_push_strategy.dart';

class UpdateAppointmentStrategy implements IPushStrategy {
  @override
  void execute(Map<String, dynamic> pushPayload) {
    print('Teste de uppdate strategy');
  }
}
