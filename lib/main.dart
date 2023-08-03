
import 'package:flutter/material.dart';
import 'package:flutter_demo/task.dart';
import 'date_ext.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedTime = DateTime.now();
  final Map<int, List<DateTime>> weeks = {};
  final List<Task> tasks = [];
  late final PageController controller;
  final int maxCount = 1<<32;
  int pageIndex = 0;

  @override
  void initState() {
    pageIndex = maxCount~/2;
    controller = PageController(initialPage: pageIndex);

    weeks[pageIndex - 1] = selectedTime.preWeek();
    weeks[pageIndex] = selectedTime.week();
    weeks[pageIndex + 1] = selectedTime.nextWeek();

    tasks.add(Task("Task 001", DateTime.now()));
    tasks.add(Task("Task 002", DateTime.now()));
    tasks.add(Task("Task 003", DateTime.now()));
    tasks.add(Task("Task 004", DateTime.now()));
    super.initState();
  }

  void _onAdd() {
    setState(() {
      tasks.insert(0, Task("New Task", DateTime.now()));
    });
  }

  void _onDateClick(DateTime date) {
    setState(() {
      selectedTime = date;
    });
  }

  void onWeekPageChanged(int index){
    pageIndex = index;

    fetchWeek(index-1);

    fetchWeek(index+1);

    setState(() {});
  }

  void fetchWeek(int index){
    if(weeks.containsKey(index))return;

    int distances = index - pageIndex;
    List<DateTime> week;
    var first = weeks[pageIndex]!.first;
    if(distances > 0){
      week = first.add(Duration(days: distances*7)).week();
    }else {
      week = first.subtract(Duration(days: -distances*7)).week();
    }
    weeks[index] = week;
  }

  Widget buildWeekView(BuildContext context, int index){
    fetchWeek(index);
    return WeekView(week: weeks[index]!, selectedTime: selectedTime, dateClick: _onDateClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Header(dateTime: selectedTime),
      ),
      body: Column(
        children: [
          SizedBox(height: 90, child: PageView.builder(
              controller: controller,
              itemCount: maxCount,
              onPageChanged: onWeekPageChanged,
              itemBuilder: buildWeekView
          )),
          Expanded(child: SizedBox.expand(child: TasksView(tasks: tasks)))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAdd,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TasksView extends StatelessWidget {
  const TasksView({super.key, required this.tasks});

  final List<Task> tasks;

  Widget buildItem(BuildContext context, int index) {
    Decoration? decoration;
    if(index != tasks.length -1){
      decoration = const TimeLineDecoration(Colors.grey, 2, Offset(24, 32));
    }
    Task task = tasks[index];
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: decoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const ShapeDecoration(color: Colors.green, shape: CircleBorder()),
            margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.content, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 2),
                    Text(task.dateTime.format("HH:mm:ss"), style: const TextStyle(fontSize: 12))
                  ],
                )
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: tasks.length, itemBuilder: buildItem);
  }
}

class TimeLineDecoration extends Decoration{
  final Color lineColor;
  final double lineWidth;
  final Offset? lineOffset;

  const TimeLineDecoration(this.lineColor, this.lineWidth, [this.lineOffset]);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TimeLinePainter(lineColor, lineWidth, lineOffset);
  }
}

class _TimeLinePainter extends BoxPainter{
  _TimeLinePainter(this.lineColor, this.lineWidth, [this.lineOffset]){
    _paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;
  }

  late final Paint _paint;
  final Color lineColor;
  final double lineWidth;
  final Offset? lineOffset;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    double offsetX = lineOffset?.dx ?? 0;
    double offsetY = lineOffset?.dy ?? 0;
    var p1 = Offset(offsetX + rect.left, rect.top+offsetY);
    var p2 = Offset(offsetX + rect.left, rect.bottom+offsetY);
    canvas.drawLine(p1, p2, _paint);
  }
}

class WeekView extends StatelessWidget {
  const WeekView({super.key, required this.week, required this.selectedTime, this.dateClick});

  final DateTime selectedTime;
  final DateClick? dateClick;
  final List<DateTime> week;

  void onDateClick(DateTime date) {
    dateClick?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: buildWeekView(week),
      ),
    );
  }

  List<Widget> buildWeekView(List<DateTime> dateList) {
    var res = <Widget>[];
    for (var date in dateList) {
      res.add(buildDateView(date));
    }
    return res;
  }

  Widget buildDateView(DateTime date) {
    const double dayBoxSize = 36;
    String day = date.format("dd");
    bool isToday = date.isSameDay(DateTime.now());
    bool isSelected = date.isSameDay(selectedTime);

    Color textColor = isSelected ? Colors.white : Colors.black;
    Color backgroundColor = isSelected ? Colors.blue : Colors.transparent;
    TextStyle dayStyle = TextStyle(fontSize: 14, color: textColor);
    Decoration background = BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(dayBoxSize));

    return Column(
      children: [
        Text(date.format("E"), style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Stack(children: [
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Container(
                  key: isSelected ? const ValueKey("AnimationPosition") : null,
                  width: dayBoxSize, height: dayBoxSize,
                  decoration: background
              )
          ),
          GestureDetector(
              onTap: () => onDateClick(date),
              child: Container(
                alignment: Alignment.center,
                width: dayBoxSize,
                height: dayBoxSize,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(dayBoxSize),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Text(day, style: dayStyle),
              )
          )
        ]),
        const SizedBox(height: 8),
        Visibility(
          visible: isToday,
          child: Container(width: 8, height: 8, decoration: const ShapeDecoration(color: Colors.red, shape: CircleBorder())),
        )
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.dateTime});

  final DateTime dateTime;

  String get year => dateTime.format("yyyy");

  String get month => dateTime.format("MMM");

  String get fullTime => dateTime.format("E, MMM dd, yyyy");

  @override
  Widget build(BuildContext context) {
    const monthStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue);
    const yearStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const descStyle = TextStyle(fontSize: 12);
    return SizedBox(
        height: 56,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text(month, style: monthStyle),
                      const SizedBox(width: 4),
                      Text(year, style: yearStyle),
                    ]),
                    Text(
                      fullTime,
                      style: descStyle,
                    )
                  ],
                )),
            Image.asset("assets/avatar.webp", width: 32, height: 32),
          ],
        ));
  }
}

typedef DateClick = void Function(DateTime date);
