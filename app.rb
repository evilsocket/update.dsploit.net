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
    static "changelog_#{version}.html"
  end 

  private

  def static(name)
    open( "#{File.dirname(__FILE__)}/files/#{name}" ).read
  end

  def version
    static 'current.version'
  end
end