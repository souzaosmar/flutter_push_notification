import 'package:push/push_notification/strategy/informacao_processual_strategy.dart';
import 'package:push/push_notification/strategy/chat_message_strategy.dart';
import 'package:push/push_notification/strategy/i_push_strategy.dart';
import 'package:push/push_notification/strategy/update_appointment_strategy.dart';

class PushNotificationFactory {
  Map<String, dynamic> pushPayload;

  IPushStrategy strategy;

  PushNotificationFactory.create(this.pushPayload) {
    print('O tipo de carga é: ${pushPayload['type']}');

    switch (pushPayload['type']) {
      case 'updaetAppointment':
        strategy = UpdateAppointmentStrategy();
        break;
      case 'chatMessage':
        strategy = ChatMessageStrategy();
        break;
      case 'informacaoProcessual':
        strategy = InformacaoProcessualStrategy();
        break;
      default:
        throw Exception('Estratégia não implementada!');
    }
  }

  void execute() {
    strategy.execute(pushPayload);
  }
}
