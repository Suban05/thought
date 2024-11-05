Sentry.init do |config|
  config.dsn = "https://examplePublicKey@o0.ingest.sentry.io/0"

  # get breadcrumbs from logs
  config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]

  # enable tracing
  # we recommend adjusting this value in production
  config.traces_sample_rate = 1.0

  # enable profiling
  # this is relative to traces_sample_rate
  config.profiles_sample_rate = 1.0
end
