class TodayMatchesModel {
  TodayMatchesModel({
    required this.todayMatchesModelGet,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.response,
  });

  final String? todayMatchesModelGet;
  final Parameters? parameters;
  final List<dynamic> errors;
  final int? results;
  final Paging? paging;
  final List<NextFixturesModel> response;

  factory TodayMatchesModel.fromJson(Map<String, dynamic> json) {
    return TodayMatchesModel(
      todayMatchesModelGet: json["get"],
      parameters: json["parameters"] == null
          ? null
          : Parameters.fromJson(json["parameters"]),
      errors: json["errors"] == null
          ? []
          : List<dynamic>.from(json["errors"]!.map((x) => x)),
      results: json["results"],
      paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
      response: json["response"] == null
          ? []
          : List<NextFixturesModel>.from(
              json["response"]!.map((x) => NextFixturesModel.fromJson(x))),
    );
  }
}

class Paging {
  Paging({
    required this.current,
    required this.total,
  });

  final int? current;
  final int? total;

  factory Paging.fromJson(Map<String, dynamic> json) {
    return Paging(
      current: json["current"],
      total: json["total"],
    );
  }
}

class Parameters {
  Parameters({
    required this.date,
  });

  final DateTime? date;

  factory Parameters.fromJson(Map<String, dynamic> json) {
    return Parameters(
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }
}

class NextFixturesModel {
  NextFixturesModel({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
  });

  final Fixture? fixture;
  final League? league;
  final Teams? teams;
  final Goals? goals;
  final Score? score;

  factory NextFixturesModel.fromJson(Map<String, dynamic> json) {
    return NextFixturesModel(
      fixture:
          json["fixture"] == null ? null : Fixture.fromJson(json["fixture"]),
      league: json["league"] == null ? null : League.fromJson(json["league"]),
      teams: json["teams"] == null ? null : Teams.fromJson(json["teams"]),
      goals: json["goals"] == null ? null : Goals.fromJson(json["goals"]),
      score: json["score"] == null ? null : Score.fromJson(json["score"]),
    );
  }
}

class Fixture {
  Fixture({
    required this.id,
    required this.referee,
    required this.timezone,
    required this.date,
    required this.timestamp,
    required this.periods,
    required this.venue,
    required this.status,
  });

  final int? id;
  final String? referee;
  final String? timezone;
  final DateTime? date;
  final int? timestamp;
  final Periods? periods;
  final Venue? venue;
  final Status? status;

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json["id"],
      referee: json["referee"],
      timezone: json["timezone"],
      date: DateTime.tryParse(json["date"] ?? ""),
      timestamp: json["timestamp"],
      periods:
          json["periods"] == null ? null : Periods.fromJson(json["periods"]),
      venue: json["venue"] == null ? null : Venue.fromJson(json["venue"]),
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
    );
  }
}

class Periods {
  Periods({
    required this.first,
    required this.second,
  });

  final int? first;
  final int? second;

  factory Periods.fromJson(Map<String, dynamic> json) {
    return Periods(
      first: json["first"],
      second: json["second"],
    );
  }
}

class Status {
  Status({
    required this.long,
    required this.short,
    required this.elapsed,
    required this.extra,
  });

  final String? long;
  final String? short;
  final int? elapsed;
  final int? extra;

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json["long"],
      short: json["short"],
      elapsed: json["elapsed"],
      extra: json["extra"],
    );
  }
}

class Venue {
  Venue({
    required this.id,
    required this.name,
    required this.city,
  });

  final int? id;
  final String? name;
  final String? city;

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json["id"],
      name: json["name"],
      city: json["city"],
    );
  }
}

class Goals {
  Goals({
    required this.home,
    required this.away,
  });

  final int? home;
  final int? away;

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      home: json["home"],
      away: json["away"],
    );
  }
}

class League {
  League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.round,
  });

  final int? id;
  final String? name;
  final String? country;
  final String? logo;
  final String? flag;
  final int? season;
  final String? round;

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json["id"],
      name: json["name"],
      country: json["country"],
      logo: json["logo"],
      flag: json["flag"],
      season: json["season"],
      round: json["round"],
    );
  }
}

class Score {
  Score({
    required this.halftime,
    required this.fulltime,
    required this.extratime,
    required this.penalty,
  });

  final Goals? halftime;
  final Goals? fulltime;
  final Goals? extratime;
  final Goals? penalty;

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      halftime:
          json["halftime"] == null ? null : Goals.fromJson(json["halftime"]),
      fulltime:
          json["fulltime"] == null ? null : Goals.fromJson(json["fulltime"]),
      extratime:
          json["extratime"] == null ? null : Goals.fromJson(json["extratime"]),
      penalty: json["penalty"] == null ? null : Goals.fromJson(json["penalty"]),
    );
  }
}

class Teams {
  Teams({
    required this.home,
    required this.away,
  });

  final Away? home;
  final Away? away;

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      home: json["home"] == null ? null : Away.fromJson(json["home"]),
      away: json["away"] == null ? null : Away.fromJson(json["away"]),
    );
  }
}

class Away {
  Away({
    required this.id,
    required this.name,
    required this.logo,
    required this.winner,
  });

  final int? id;
  final String? name;
  final String? logo;
  final bool? winner;

  factory Away.fromJson(Map<String, dynamic> json) {
    return Away(
      id: json["id"],
      name: json["name"],
      logo: json["logo"],
      winner: json["winner"],
    );
  }
}
