import 'package:bloc/bloc.dart';
import 'package:gemini_genius/models/chat_message_model.dart';
import 'package:gemini_genius/repos/chat_repo.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }

  List<ChatMessageModel> messages = [];
  bool generating = false;

  Future<void> chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
    emit(ChatSuccessState(messages: List.from(messages)));
    generating = true; // Ensure immutability by passing a copy of the list
    String? generatedText = await GeminiGenius.chatTextGenerationRepo(messages);
    if (generatedText != null && generatedText.isNotEmpty) {
      messages.add(ChatMessageModel(
          role: "model", parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSuccessState(
          messages: List.from(
              messages))); // Ensure immutability by passing a copy of the list
    }
    generating = false; // Ensure immutability by passing a copy of the list
  }
}
