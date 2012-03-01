guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/mongohq/(.+)\.rb$}) { |m| "spec/integration/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

