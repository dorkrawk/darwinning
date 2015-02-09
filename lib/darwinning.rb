require_relative 'darwinning/gene'
require_relative 'darwinning/organism'
require_relative 'darwinning/evolution_types/mutation'
require_relative 'darwinning/evolution_types/reproduction'
require_relative 'darwinning/population'
require_relative 'darwinning/config'
require_relative 'darwinning/implementation'

module Darwinning
  extend Config
  include Implementation
end