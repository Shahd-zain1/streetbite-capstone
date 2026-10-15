import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/constants/app_constants.dart';
import 'package:streetbite/core/utils/error_kind_message.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/presentation/blocs/meals/meals_cubit.dart';
import 'package:streetbite/presentation/blocs/meals/meals_state.dart';
import 'package:streetbite/presentation/widgets/error_view.dart';
import 'package:streetbite/presentation/widgets/featured_banner.dart';
import 'package:streetbite/presentation/widgets/home_greeting.dart';
import 'package:streetbite/presentation/widgets/hot_offers_section.dart';
import 'package:streetbite/presentation/widgets/section_title.dart';
import 'package:streetbite/presentation/widgets/sliver_meals_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<MealsCubit, MealsState>(
      builder: (context, state) {
        if (state.status == MealsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == MealsStatus.error) {
          return ErrorView(
            message: state.error!.message(l10n),
            onRetry: () => context.read<MealsCubit>().load(),
          );
        }
        final meals = state.meals;
        return RefreshIndicator(
          onRefresh: () => context.read<MealsCubit>().load(forceRefresh: true),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: HomeGreeting()),
              SliverToBoxAdapter(
                child: FeaturedBanner(
                  meals: meals.take(AppConstants.bannerCount).toList(),
                ),
              ),
              SliverToBoxAdapter(
                child: HotOffersSection(
                  meals: meals.reversed
                      .take(AppConstants.hotOffersCount)
                      .toList(),
                ),
              ),
              SliverToBoxAdapter(child: SectionTitle(l10n.allMealsTitle)),
              SliverMealsGrid(meals: meals),
            ],
          ),
        );
      },
    );
  }
}
