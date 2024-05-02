class Upgrade {
    Upgrade({
        required this.found,
        required this.forceUpgrade,
        required this.message,
        required this.query,
    });

    final bool found;
    final bool forceUpgrade;
    final String message;
    final Query query;
}

class Query {
    Query({
        required this.appName,
        required this.appVersion,
        required this.platform,
        required this.environment,
    });

    final String appName;
    final String appVersion;
    final String platform;
    final String environment;
}
