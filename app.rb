require 'sinatra'

configure {
  set :server, :puma
}

class UpdateServer < Sinatra::Base
  set :static, true
  set :public_dir, File.dirname(__FILE__) + '/files'

  get '/version' do
    version
  end

  get '/apk' do
    redirect "http://#{request.host}/dSploit-#{version}.apk"
  end

  get '/changelog' do
    open( "#{File.dirname(__FILE__)}/files/changelog_#{version}.html" )
  end 

  private

  def version
    open( "#{File.dirname(__FILE__)}/files/current.version" ).read
  end
end