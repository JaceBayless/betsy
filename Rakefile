# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: :rubocop
task :console do
  exec "irb -r betsy -I ./lib"
end
