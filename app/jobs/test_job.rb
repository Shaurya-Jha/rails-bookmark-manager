class TestJob < ApplicationJob
  queue_as :default

  def test_log(arg)
    puts "Test job logs: #{arg}"
  end
end