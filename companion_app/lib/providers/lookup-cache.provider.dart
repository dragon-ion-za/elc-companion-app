import 'dart:async';

import 'package:elc_companion_app/models/lookup-cache.dart';
import 'package:elc_companion_app/providers/auth.provider.dart';
import 'package:elc_companion_app/services/api_services/lookup_api.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LookupCacheNotifier extends AsyncNotifier<LookupCache> {
  LookupCacheNotifier();

  @override
  FutureOr<LookupCache> build() async {
    await loadCache();
    return state.value!;
  }

  Future loadCache() async {
    state = const AsyncLoading();

    final accessToken = ref.read(authProvider)!.accessToken;
    state = await AsyncValue.guard(
        () async {
            final races = await LookupApiService(accessToken!).getRaces();
            final factions = await LookupApiService(accessToken!).getFactions();
            final eras = await LookupApiService(accessToken!).getEras();
            final talentsFlaws = await LookupApiService(accessToken!).getTalentsFlaws();
            final skills = await LookupApiService(accessToken!).getSkills();

            return LookupCache(races, factions, eras, talentsFlaws, skills);
        } );
  }
}

final lookupCacheProvider =
    AsyncNotifierProvider<LookupCacheNotifier, LookupCache>(
        LookupCacheNotifier.new);
