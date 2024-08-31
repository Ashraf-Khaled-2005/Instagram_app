import 'package:go_router/go_router.dart';
import 'package:instagram_app/features/Story/presentation/view/SortyAdding.dart';
import 'package:instagram_app/features/Story/presentation/view/widget/storybody.dart';
import 'package:instagram_app/features/authication/presentation/view/signup/SignupPage.dart';
import '../features/authication/presentation/view/signin/Loginpage.dart';
import '../features/comment/presentation/view/Commentpage.dart';
import 'Bottombar.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/s',
      builder: (context, state) => Bottombar(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: '/story',
      builder: (context, state) => StoryPage(),
    ),
    GoRoute(
      path: '/Login',
      builder: (context, state) => LogInPage(),
    ),
  ],
);
