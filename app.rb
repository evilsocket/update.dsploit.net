require 'sinatra'

configure {
  set :server, :puma
}

class UpdateServer < Sinatra::Base
  set :static, true
  set :public_dir, File.dirname(__FILE__) + '/files'

  get '/' do
    redirect "http://www.dsploit.net/"
  end

  get '/version' do
    version
  end

  get '/apk' do
    redirect "http://update.dsploit.net/stable/dSploit-#{version}.apk"
  end

  get '/nightly' do
    redirect "http://rootbitch.cc/dsploit/dSploit-latest.apk"
    #redirect "http://update.dsploit.net/nightly/dSploit-#{version(true)}.apk"
  end

  get '/changelog' do
    static "changelog_#{version}.html"
  end 

  private

  def static(name)
    open( File.join( settings.public_dir, name ) ).read.strip
  end

  def version( nightly = false )
    static nightly ? 'nightly.version' : 'current.version'
  end
end
