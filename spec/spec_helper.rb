require 'darwinning'

Dir[
  File.join(File.dirname(__FILE__), './classes/*.rb'),
].each { |file| require file }