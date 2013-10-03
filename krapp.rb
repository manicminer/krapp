#!/usr/bin/env ruby

require 'sinatra'

set :bind, '127.0.0.1'
set :port, 8808

get '/' do
  '<form method="post"><label>Principal <input type="text" name="principal"/></label><br/>
   <label>Password <input type="password" name="password"/></label><br/>
   <input type="submit" value="Get Ticket"/></form>'
end

post '/' do
  result = `echo '#{params[:password]}' | kinit #{params[:principal]} >/dev/null; echo $?`
  if result.to_i == 0
    klist = `klist`
    "<pre style=\"font-weight:bold'\">#{klist}</pre>"
  else
    "Could not acquire TGT :-("
  end
end
