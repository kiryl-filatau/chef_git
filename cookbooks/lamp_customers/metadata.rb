name 'lamp_customers'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures lamp_customers'
long_description 'Installs/Configures lamp_customers'
version '0.2.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/learn-chef/lamp_customers/issues' if respond_to?(:issues_url)
source_url 'https://github.com/learn-chef/lamp_customers' if respond_to?(:source_url)
supports 'ubuntu'

depends 'lamp'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/lamp_customers/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/lamp_customers'
