#!/usr/bin/ruby


def cmd_line()
  options = {}
  optparse = OptionParser.new do|opts|

    opts.banner = "Usage: #{opts.program_name}"

    opts.on("-s","--session [STRING]","session name") do |s|
      options[:session] = s
    end
    
    opts.on("-h","--host_list [STRING]","path to host list.") do |s|
      options[:host_list] = s
    end

    options[:max_panes] = 20
    opts.on("-m","--max_panes [INT]","Max number of panes per session.") do |s|
      options[:max_panes] = s
    end

  end

  optparse.parse!
  return options
end

def get_hosts(opts)
	contents = IO.readlines(options[:host_list]).map(&:chomp)
end

def starttmux(opts)
	max_pane = opts[:max_panes]
	host_ary = opts[:hosts]
	cmd = opts[:tmux_bin]
	session = opts[:session]

	ittr_hosts = host_ary.each_slice(max_pane).to_a
	ittr_hosts.each do |mem_ary|
		system("#{cmd} new-session -d -s #{session}")
		mem_ary.each do |host|
			puts "Adding #{host}"
			run="#{cmd} split-window -v -t #{session} \'ssh -l %{user} %{host}\'"
			system(run)
			tmux select-layout tiled
		end
		system("#{cmd} set-window-option synchronize-panes on")
		system("#{cmd} kill-pane -t 0")
		system("#{cmd} attach -t #{session}")
	end
end
