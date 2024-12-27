class Seasons {
    Seasons({
        required this.seasonsGet,
        required this.parameters,
        required this.errors,
        required this.results,
        required this.paging,
        required this.response,
    });

    final String? seasonsGet;
    final List<dynamic> parameters;
    final List<dynamic> errors;
    final int? results;
    final Paging? paging;
    final List<int> response;

    factory Seasons.fromJson(Map<String, dynamic> json){ 
        return Seasons(
            seasonsGet: json["get"],
            parameters: json["parameters"] == null ? [] : List<dynamic>.from(json["parameters"]!.map((x) => x)),
            errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
            results: json["results"],
            paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
            response: json["response"] == null ? [] : List<int>.from(json["response"]!.map((x) => x)),
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

    factory Paging.fromJson(Map<String, dynamic> json){ 
        return Paging(
            current: json["current"],
            total: json["total"],
        );
    }

}