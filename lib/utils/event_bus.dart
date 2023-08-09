

class EventBus{
  EventBus._internal();

  // static final EventBus _instance = EventBus._internal();
  //
  // factory EventBus() => _instance;

  static final Map<String, List<Subscriber>> _subscribers = {};
  static final Map<Subscriber, List<String>> _events = {};

  static void subscribe(List<String> events, Subscriber subscriber){
    for (var event in events) {
      _subscribe(event, subscriber);
    }
    _events[subscriber] = events;
  }

  static void _subscribe(String event, Subscriber subscriber){
    var subscribers = _subscribers[event];
    if(subscribers == null){
      subscribers = [];
      _subscribers[event] = subscribers;
    }

    if(!subscribers.contains(subscriber)) {
      subscribers.add(subscriber);
    }
  }

  static void unsubscribe(Subscriber subscriber){
    var events = _events[subscriber];
    if(events == null) return;
    _events.remove(subscriber);
    for (var event in events) {
      _unsubscribe(event, subscriber);
    }
  }

  static void _unsubscribe(String event, Subscriber subscriber){
    var subscribers = _subscribers[event];
    if(subscribers == null) return;
    subscribers.remove(subscriber);
  }

  static void emit(String event, [Object? payload]){
    var subscribers = _subscribers[event];
    if(subscribers == null || subscribers.isEmpty) return;
    for (var subscriber in subscribers) {
      subscriber.onEvent(event, payload);
    }
  }
}

abstract class Subscriber{
  void onEvent(String event, Object? payload);
}