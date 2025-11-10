require 'open-uri'

class RootController < ApplicationController
  HOST = ENV.fetch('HOST', 'https://rocket-rust-hello-world-jblg.onrender.com')

  delegate :base_uri, to: :uri
  delegate :meta, to: :uri
  delegate :status, to: :uri

  def root_params
    params.permit(
      :emoji,
      :lang,
      :name
    )
  end

  def uri
    @uri ||= URI.open("#{HOST}/?#{root_params.to_query}")
  end

  def body
    @body ||= uri.as_json
  end

  def json
    {
      base_uri: base_uri,
      meta: meta,
      status: status,
      body: body
    }
  end

  def index
    render(json: json)
  end
end
