default['fluentd']['config']['couch']['host'] = "db.analytics.dimsum.hk"
default['fluentd']['config']['couch']['database'] = "bbc_monitor"

default['fluentd']['config']['couch']['flush_interval'] = "2s"


default['fluentd']['config']['s3']['bucket'] = "bbc.analytics.data"
default['fluentd']['config']['s3']['endpoint'] = "s3-eu-west-1.amazonaws.com"
default['fluentd']['config']['s3']['buffer_path'] = "/var/log/fluent/s3"
default['fluentd']['config']['s3']['buffer_chunk_limit'] = "256m"
default['fluentd']['config']['s3']['flush_interval'] = "10m"




