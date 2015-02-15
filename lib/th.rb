require "th/version"

require_relative 'th/commands/create_parse'
require_relative 'th/executors/create'

require_relative 'th/commands/register_parse'
require_relative 'th/executors/register'

require_relative 'th/commands/key_add_parse'
require_relative 'th/executors/key_add'

require_relative 'th/commands/branch_add_parse'
require_relative 'th/executors/branch_add'

require_relative 'th/commands/branch_remove_parse'
require_relative 'th/executors/branch_remove'

require_relative 'th/commands/env_add_parse'
require_relative 'th/executors/env_add'

require_relative 'th/commands/login_parse'
require_relative 'th/executors/login'

require_relative 'th/commands/join_parse'
require_relative 'th/executors/join'

require_relative 'th/commands/scale_parse'
require_relative 'th/executors/scale'

require_relative 'th/commands/docker_parse'
require_relative 'th/executors/docker'

require_relative 'th/commands/deploy_parse'
require_relative 'th/executors/deploy'

require_relative 'th/commands/versions_parse'
require_relative 'th/executors/versions'

require_relative 'th/commands/restart_parse'
require_relative 'th/executors/restart'
