Ost Scheduler
===

Ost-Scheduler is an extension to [Ost](http://github.com/soveran/ost) that adds support for queueing items in the future.

Description
-----------

Ost provides simple, lightweight background job functionality. 

**Ost-Scheduler** makes it easy to enqueue object ids and process them with
workers.

Say you want to process video uploads. In your application you will
have something like this:

``` ruby
Ost[:videos_to_process].push_at( Time.now + 60 , @video.id )
```

Then, you will have a worker that will look like this:

``` ruby
require "ost-scheduler"

Ost[:videos_to_process].each_delayed do |id|
  # Do something with it!
end
```

Usage
-----

Ost uses a lightweight Redis client called [Redic][redic]. To connect to
a Redis database, you will need to set an instance of `Redic`, with a URL
of the form `redis://:<passwd>@<host>:<port>/<db>`.

You can customize the connection by calling `Ost.redis=`:

``` ruby
require "ost-scheduler"

Ost.redis = Redic.new("redis://127.0.0.1:6379")
```

Then you only need to refer to a queue for it to pop into existence:

``` ruby
require "ost-scheduler"

Ost.redis = Redic.new("redis://127.0.0.1:6379")

Ost[:event].push_at(@datetime, @feed.id)
```

Ost defaults to a Redic connection to `redis://127.0.0.1:6379`. The example
above could be rewritten as:

``` ruby
require "ost-scheduler"

Ost[:event].push_at(@datetime, @feed.id)
```

A worker is a Ruby file with this basic code:

``` ruby
require "ost-scheduler"

Ost[:rss_feeds].each_delayed do |id|
  # ...
end
```


Available methods
=================

`Ost[:example].push_at(datetime, item)`: add `item` to
the `:example` queue in a exactly `datetime`.

`Ost[:example].each_delayed { |item| ... }`: consume `item` from the `:example` queue. .

`Ost.stop`: halt processing for all queues.

`Ost[:example].stop`: halt processing for the `example` queue.

Installation
------------

    $ gem install ost-scheduler
