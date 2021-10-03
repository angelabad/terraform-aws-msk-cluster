
<a name="v0.4.2"></a>
## [v0.4.2](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.4.1...v0.4.2) (2021-10-03)

### Bug Fixes

* Allow tls zookeper traffic
* Rename zookeper security group rule to zookeeper-plain


<a name="v0.4.1"></a>
## [v0.4.1](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.4.0...v0.4.1) (2021-09-26)

### Bug Fixes

* Support in-place kafka version upgrades (thanks [@bradonkanyid](https://github.com/bradonkanyid))


<a name="v0.4.0"></a>
## [v0.4.0](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.3.5...v0.4.0) (2021-07-04)

### Bug Fixes

* Correct usage of random_id keepers
* Support in-place instance_type updates

### Features

* Update examples kafka versions
* Require terraform >= 0.15 for new provider versions


<a name="v0.3.5"></a>
## [v0.3.5](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.3.4...v0.3.5) (2021-03-07)

### Features

* Support PER_TOPIC_PER_PARTITION value for enhanced_monitoring (thanks [@victorcmoura](https://github.com/victorcmoura))


<a name="v0.3.4"></a>
## [v0.3.4](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.3.3...v0.3.4) (2020-11-11)

### Bug Fixes

* Update README example code


<a name="v0.3.3"></a>
## [v0.3.3](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.3.2...v0.3.3) (2020-09-12)

### Bug Fixes

* Use create_before_destroy on aws_msk_configuration to avoid update errors


<a name="v0.3.2"></a>
## [v0.3.2](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.3.1...v0.3.2) (2020-05-03)

### Features

* Add complete msk cluster example
* Add simple msk cluster example


<a name="v0.3.1"></a>
## [v0.3.1](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.3.0...v0.3.1) (2020-04-26)

### Bug Fixes

* Fix logs options usage example
* Conditionaly open jmx and node exporter ports on security group
* Use empty strings instead of null in optional variables


<a name="v0.3.0"></a>
## [v0.3.0](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.2.0...v0.3.0) (2020-04-23)

### Features

* Add support for logging_info, s3, cloudwatch and firehose
* Configure minimum required versions


<a name="v0.2.0"></a>
## [v0.2.0](https://github.com/angelabad/terraform-aws-msk-cluster/compare/v0.1.0...v0.2.0) (2020-04-21)

### Features

* Add enhanced_monitoring options
* Add tags map to msk cluster resource


<a name="v0.1.0"></a>
## v0.1.0 (2020-04-20)

### Features

* Add readme file
* Add descriptions on variables and outputs
* Initial module commit
