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
    filename = "dSploit-#{version}.apk"
    send_file File.join( settings.public_dir, 'stable', filename ), :filename => filename
  end

  get '/nightly' do
    filename = "dSploit-#{version(true)}.apk"
    send_file File.join( settings.public_dir, 'nightly', filename ), :filename => filename
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
