#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'terminal-notifier'

command = %q(osascript -e 'tell application "Safari" to get URL of front document')

IO.popen(command, 'r') do |p|
  url = p.read.chomp
  elm = Nokogiri::HTML(open(url)).xpath('//link[@rel="canonical"]')
  if elm.empty?
    TerminalNotifier.notify 'No canonical URL found.', title: 'Canonical URL'
  else
    canonical_url = elm.attr('href').value
    IO.popen('pbcopy', 'w') { |q| q.write canonical_url }
    TerminalNotifier.notify canonical_url,
      title: 'Canonical URL',
      open: canonical_url
  end
end
