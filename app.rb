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
    send_file "#{settings.public_dir}/stable/dSploit-#{version}.apk", :filename => "dSploit-#{version}.apk"
  end

  get '/nightly' do
    send_file "http://#{request.host}/nightly/dSploit-#{version(true)}.apk",  :filename => "dSploit-#{version(true)}.apk"
  end

  get '/changelog' do
    static "changelog_#{version}.html"
  end 

  private

  def static(name)
    open( "#{File.dirname(__FILE__)}/files/#{name}" ).read.strip
  end

  def version( nightly = false )
    static nightly ? 'nightly.version' : 'current.version'
  end
end
