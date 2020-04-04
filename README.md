# Multi Ruby Runner

This gem lets you call Ruby code in one Ruby environment from Ruby code in another environment.

It makes use of Ruby version managers to switch the Ruby runtime environment. Typically you will write a ruby script that executes the code you want and call that script via MultiRubyRunner in the desired Ruby runtime environment.

Examples:

* Call JRuby code from MRI 2.3.0
* Call MRI 1.9.3 code from MRI 2.2.1

## Requirements

### Operating system

* Linux: Not tested, but should work.
* OS X: Tested and works.
* Windows: I don’t think it works, and I have no plans of supporting this scenario.

### Ruby version manager

* rbenv: Works
* RVM: Works
* None: You really should use a Ruby version manager :-)

### Ruby versions

Caller: The Ruby code that invokes other ruby code.
Callee: The Ruby code being invoked.

* MRI: Works for caller and callee.
* JRuby: Works for callee. May not work for caller as we use `fork` in a non-blocking use case.
* Rubinius: Not tested, however it should work.

### Bundler

We have Bundler baked into the Gem via `Bundler.with_clean_env`. This is not necessary for overall functionality. I assume you’re using Bundler.

## Installation

Add this line to your application's Gemfile:

    gem 'multi_ruby_runner'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multi_ruby_runner

## Usage

### Blocking (without fork)

If you want to execute a Ruby script and wait for its result via output to STDOUT, use this snippet:

    mrr = MultiRubyRunner.new
    stdout = mrr.execute_command_in_directory(
      "./bin/ruby-script-to-execute argument1 argument2",
      "/path/to/folder/that/sets/ruby/env"
    )

Note that we’re passing `argument1` and `argument2` as positional arguments to the callee Ruby script.

### Non blocking (with fork)

If you just want to start a process and return back to the caller right away, you can set the `:blocking` option to false. In that case you will get the child process’ PID as return value. This is useful if you want to start a service and communicate with it e.g., via `Sockets`.

    mrr = MultiRubyRunner.new
    child_pid = mrr.execute_command_in_directory(
      "./bin/ruby-script-to-execute argument1 argument2",
      "/path/to/folder/that/sets/ruby/env",
      blocking: false
    )

You can communicate with the child process via pipes or sockets.

### Ruby scripts to call

Here is an example Ruby script that can be called via MultiRubyRunner:

    #!/usr/bin/env ruby

    # This is an example callee script for MultiRubyRunner

    require_relative '../lib/path/to/your/ruby/code'

    # Check for arguments
    arg1 = ARGV[0]
    arg2 = ARGV[1]

    # Puts will return some text to STDOUT
    puts "The current time is #{ Time.now }"

Please note that even if you use JRuby, you keep `ruby` in the shebang. Your Ruby version manager will make sure that the code will be executed by JRuby.

## Additional resources

I found Jesse Storimer’s books `Working With Unix Processes` and `Working With TCP Sockets` very helpful.

## Contributing

1. Fork it ( https://github.com/jhund/multi_ruby_runner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Resources

* [Source code (github)](https://github.com/jhund/multi_ruby_runner)
* [Issues](https://github.com/jhund/multi_ruby_runner/issues)
* [Rubygems.org](http://rubygems.org/gems/multi_ruby_runner)

### License

[MIT licensed](https://github.com/jhund/multi_ruby_runner/blob/master/LICENSE.txt).

### Copyright

Copyright (c) 2016 Jo Hund. See [(MIT) LICENSE](https://github.com/jhund/multi_ruby_runner/blob/master/LICENSE.txt) for details.
