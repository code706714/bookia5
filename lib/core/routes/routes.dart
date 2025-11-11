import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/forgetpassword/sendotp.dart';
import 'package:bookia/feature/auth/presentation/login/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/register/page/register_screen.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/presentation/page/place_order_screen.dart';
import 'package:bookia/feature/home/data/models/best_seller_response/product.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/page/details_screen.dart';
import 'package:bookia/feature/main/main_app_screen.dart';
import 'package:bookia/feature/splash/splash_screen.dart';
import 'package:bookia/feature/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// global key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splashScreen = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String AuthFlow = '/AuthFlowScreen';
  static const String main = '/main';
  static const String details = '/details';
  static const String placeOrder = '/PlaceOrderScreen';

  static GoRouter routes = GoRouter(
    // initialLocation: splashScreen,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: main,
        builder: (context, state) => MainAppScreen(index: state.extra as int?),
      ),
      GoRoute(
        path: details,
        builder: (context, state) {
          var book = state.extra as Product;
          return BlocProvider(
            create: (context) => HomeCubit(),
            child: DetailsScreen(book: book),
          );
        },
      ),
      GoRoute(
        path: placeOrder,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => CartCubit()..prefillOrderData(),
            child: PlaceOrderScreen(total: state.extra as String),
          );
        },
      ),
       GoRoute(
        path: AuthFlow,
        builder: (context, state) => AuthFlowScreen(),
      ),
    ],
  );
}
