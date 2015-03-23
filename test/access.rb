require_relative "helper"

scope do

  test "access to delayed queued items" do
    Ost[:events].push_at((Time.now + 60), 1)

    assert_equal ["1"], Ost[:events].items
  end

  test "access to queue size" do
    queue = Ost[:events]
    assert_equal 0, queue.size

    queue.push_at((Time.now), 1)
    assert_equal 1, queue.size

    queue.stop
    queue.each_delayed { }
    assert_equal 0, queue.size
  end
end
