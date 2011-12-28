# -*- Ruby -*-
# Based heavily upon:
# http://squarism.com/2010/05/23/watchr-unit-tests-growl-doomguy/
# http://www.rubyinside.com/how-to-rails-3-and-rspec-2-4336.html

ENV["WATCHR"] = "1"
system 'clear'

def growl_results(testfile, results)
  growlnotify = `which growlnotify`.chomp
  title = "#{testfile}"
#  image = message.include?('0 failures, 0 errors') ? "~/.watchr_images/passed.png" : "~/.watchr_images/failed.png"
  # TODO: need to get better parsing, at least the gem color works
  image = ".watchr_images/pending.png"
  message = results
  if (results =~ /(\d+) examples, (\d+) failures/) 
    examples = $1.to_i
    failures = $2.to_i
    message = "#{examples} examples, #{failures} failures"
    image = failures == 0 ? ".watchr_images/passed.png" : ".watchr_images/failed.png"
  end

  options = "-w -n Watchr --image '#{File.expand_path(image)}' -m '#{message}' '#{title}'"
  # system %(#{growlnotify} #{options} &)
  run("#{growlnotify} #{options} &")
end

def growl_general(message)
  growlnotify = `which growlnotify`.chomp
  title = "Watchr Message"
  image = ".watchr_images/info.png"
  options = "-w -n Watchr --image '#{File.expand_path(image)}' -m '#{message}' '#{title}'"
  system %(#{growlnotify} #{options} &)
end

def run(cmd)
  puts(cmd)
  `#{cmd}`
end

def run_spec(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    # may want to have it run all tests, then
    return
  end
  system('clear')
  result = run("bundle exec rspec #{file} --format p")
  growl_results(file, result) rescue nil
  puts result
end


def run_all_tests
  run_spec("spec")
end

#def run_all_features
#  system('clear')
#  run "cucumber"
#end

#def related_test_files(path)
#  Dir['test/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_test.rb/ }
#end

#def run_suite
#  run_all_tests
#  run_all_features
#end
#watch('.watchr') { growl_general("Watchr reconfigured")}
watch('spec/spec_helper\.rb') { run_all_tests }
watch('spec/.*/.*_spec\.rb') { |m| run_spec(m[0]) }
#watch('app/.*/.*\.rb') { |m| related_test_files(m[0]).map {|tf| run_test_file(tf) } }
#watch('features/.*/.*\.feature') { run_all_features }
watch("app/(.*/.*).rb") do |match|
  run_spec %{spec/#{match[1]}_spec.rb}
end 
watch("app/(.*/.*).erb") {run_all_tests}


# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_suite
  end
end
