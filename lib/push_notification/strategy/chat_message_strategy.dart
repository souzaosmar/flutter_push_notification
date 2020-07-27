import 'package:push/push_notification/strategy/i_push_strategy.dart';

class ChatMessageStrategy implements IPushStrategy {
  @override
  void execute(Map<String, dynamic> pushPayload) {
    print('Chat message strategy teste');
  }
}
