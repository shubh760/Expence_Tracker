import 'package:expence_tracker/screens/blog.dart';
import 'package:expence_tracker/screens/home.dart';
import 'package:expence_tracker/screens/recents.dart';
import 'package:expence_tracker/screens/rewards.dart';

List pages = const [HomePage(), RecentTransactions(), Rewards(), BlogPage()];

List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

String Url =
    'https://newsapi.org/v2/everything?q=tesla&from=2022-07-24&sortBy=publishedAt&apiKey=28920105fbea439ea30eca94a900605d';
