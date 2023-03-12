abstract class QueryStringGenerator {
  String generate({
    Map<String, String>? map,
  });
}

class GithubQueryStringGenerator implements QueryStringGenerator {
  @override
  String generate({Map<String, String>? map}) {
    if (map == null) return '';
    return '?q=${map.entries.map((e) => '${e.key}:${e.value}').toList().join('+')}';
  }
}
